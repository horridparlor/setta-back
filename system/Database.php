<?php

namespace system;
require_once 'loadEnv.php';

enum RequestType: string {
    case GET = 'GET';
    case POST = 'POST';
}
const POST_REQUEST = 'POST';

class Database
{
    private \PDO $pdo;
    private array $params;

    public function __construct()
    {
        loadEnv();
        $this->connect();
        $this->allowCORS();
        $this->getGetParams();
    }

    private function connect()
    {
        $host = $_ENV['DB_HOST'];
        $user = $_ENV['DB_USER'];
        $pass = $_ENV['DB_PASS'];
        $dbname = $_ENV['DB_NAME'];
        $dsn = "mysql:host=$host;dbname=$dbname;charset=utf8mb4";

        try {
            $this->pdo = new \PDO($dsn, $user, $pass);
            $this->pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
        } catch (\PDOException $e) {
            die("Failed to connect to DATABASE: " . $e->getMessage());
        }
    }

    public function query(string $sql, ?array $replacements = array(), ?bool $debug = false): array
    {
        if ($debug) {
            echo json_encode($replacements);
            echo $sql;
        }

        $stmt = $this->pdo->prepare($sql);

        foreach ($replacements as $key => $data) {
            $value = $data['value'];
            $type = $data['type'];
            $stmt->bindValue(":$key", $value, $type);
        }

        if (!$stmt->execute()) {
            throw new \Exception('PDO statement execution failed: ' . $stmt->errorInfo()[2]);
        }

        if ($stmt->columnCount() > 0) {
            return $stmt->fetchAll(\PDO::FETCH_ASSOC);
        } else {
            return ['affected_rows' => $stmt->rowCount()];
        }
    }
    public function getInsertId(): int {
        return intval($this->query('SELECT LAST_INSERT_ID() id;')[0]['id']);
    }

    public static function arrify(array $ids): string
    {
        return "(" . implode(", ", $ids) . ")";
    }

    private static function getRequestParams(RequestType $requestType): array {
        return match($requestType) {
            RequestType::GET => $_GET,
            default => json_decode(file_get_contents("php://input"), true) ?? [],
        };
    }

    public function getGetParams(): void {
        $this->params = self::getRequestParams(RequestType::GET);
    }
    public function getPostParams(): void {
        $this->params = self::getRequestParams(RequestType::POST);
    }

    public function getIntParam(string $id, mixed $default = null)
    {
        $value = $this->params[$id];
        if (is_null($value) or $value === '') {
            return $default;
        }
        return intval($value);
    }
    public function getFloatParam(string $id, mixed $default = null)
    {
        $value = $this->params[$id];
        if (is_null($value)) {
            return $default;
        }
        return floatval($value);
    }

    public function getStringParam(string $id, mixed $default = null)
    {
        $value = $this->params[$id];
        if (is_null($value)) {
            return $default;
        }
        return urldecode($value);
    }

    public function getRawStringParam(string $id, mixed $default = null)
    {
        $value = $this->params[$id];
        if (is_null($value)) {
            return $default;
        }
        return $this->params[$id];
    }

    public function getBooleanParam(string $id, mixed $default = null)
    {
        $value = $this->params[$id];
        if (is_null($value)) {
            return $default;
        }
        return boolval($value);
    }

    public static function allowCORS(): void
    {
        if (isset($_SERVER['HTTP_ORIGIN'])) {
            header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
            header('Access-Control-Allow-Credentials: true');
            header('Access-Control-Max-Age: 86400');
            header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
        }

        if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {

            if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
                header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");

            if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
                header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

            exit(0);
        }
    }

    private function execute(?callable $function, string $errorMessage): string {
        if (is_callable($function)) {
            return $function($this);
        } else {
            return $errorMessage;
        }
    }

    function handleRequest(?callable $getFunction = null, ?callable $postFunction = null, ?callable $putFunction = null, ?callable $deleteFunction = null): void {
        $method = $_SERVER['REQUEST_METHOD'];
        $errorMessage = json_encode(["status" => "Error", "message" => "Unsupported request method"]);
        echo match ($method) {
            'GET' => $this->execute($getFunction, $errorMessage),
            'POST' => $this->executePost($postFunction, $errorMessage),
            'PUT' => $this->executePost($putFunction, $errorMessage),
            'DELETE' => $this->executePost($deleteFunction, $errorMessage),
            default => $errorMessage,
        };
    }

    function executePost(callable $postFunction, string $errorMessage): string
    {
        $this->getPostParams();
        return $this->execute($postFunction, $errorMessage);
    }

    private static function getReplacement(mixed $value, int $type): array {
        return array('value' => $value, 'type' => $type);
    }

    public static function getIntReplacement(mixed $value): array {
        return self::getReplacement($value, \PDO::PARAM_INT);
    }

    public static function getStringReplacement(mixed $value): array {
        return self::getReplacement($value, \PDO::PARAM_STR);
    }

    public static function responseSuccess(array $json): string {
        http_response_code(200);
        return json_encode($json);
    }
    public static function responseBadRequest(string $errorMessage): string {
        http_response_code(400);
        return json_encode(array('error' => $errorMessage));
    }


    public static function responseNotFound(array $json): string {
        http_response_code(404);
        return json_encode($json);
    }

    public static function responseUnsupported(array $json): string {
        http_response_code(415);
        return json_encode($json);
    }

    public static function responseForbidden(array $json): string {
        http_response_code(403);
        return json_encode($json);
    }

    public static function responseUnauthorized(array $json = array(
        'error' => 'Please authenticate'
    )): string {
        http_response_code(401);
        return json_encode($json);
    }

    public function getUser(): User|null {
        $headers = apache_request_headers();
        $authHeader = $headers["Authorization"] ?? $headers["authorization"] ?? $_SERVER['HTTP_AUTHORIZATION'] ?? $_SERVER['REDIRECT_HTTP_AUTHORIZATION'] ?? null;

        $token = null;
        if ($authHeader && preg_match('/Bearer\s(\S+)/', $authHeader, $matches)) {
            $token = $matches[1];
        }
        if (!$token) {
            return null;
        }
        $sql = <<<SQL
            SELECT
                user.id id,
                username,
                isAdmin
            FROM authToken
            JOIN user
                ON user.id = authToken.userId
            WHERE token = :token
            AND expiration > NOW();
        SQL;
        $replacements = array(
            'token' => ['value' => $token, 'type' => \PDO::PARAM_STR],
        );
        $user = self::query($sql, $replacements);
        if (!sizeof($user)) {
            return null;
        }
        return new User(intval($user[0]['id']), $user[0]['username'], boolval($user[0]['isAdmin']));
    }
    public function getRequestData(): \stdClass {
        return json_decode(json_encode($this->params));
    }
}
