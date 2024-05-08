<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");

function authenticate(Database $database): string
{
    $username = $database->getStringParam('username');
    $password = $database->getStringParam('password');
    $sql = <<<SQL
        SELECT id, passwordHash
        FROM user
        WHERE username = :username
    SQL;
    $replacements = array(
        'username' => ['value' => $username, 'type' => PDO::PARAM_STR],
    );
    $user = $database->query($sql, $replacements);
    if (!sizeof($user)) {
        return $database->responseUnauthorized(array(
            'error' => "Incorrect username or password",
        ));
    }
    $realHash = $user[0]['passwordHash'];
    if (!$realHash || !password_verify($password, $realHash)) {
        return $database->responseUnauthorized(array(
            'error' => "Incorrect username or password",
        ));
    }

    $token = bin2hex(random_bytes(16));
    $expiration = time() + 24 * 3600;
    $expirationDate = date('Y-m-d H:i:s', $expiration);
    $userId = $user[0]['id'];
    $sql = <<<SQL
        INSERT INTO authToken ( 
            userId,
            token,
            expiration
        ) VALUES (
            :userId,
            :token,
            :expiration
        )
    SQL;
    $replacements = array(
        'userId' => ['value' => $userId, 'type' => PDO::PARAM_STR],
        'token' => ['value' => $token, 'type' => PDO::PARAM_STR],
        'expiration' => ['value' => $expirationDate, 'type' => PDO::PARAM_STR],
    );
    $database->query($sql, $replacements);

    return $database->responseSuccess(array(
        'authToken' => $token,
        'userId' => $userId
    ));
}

$database = new Database();
$database->handleRequest(null, 'authenticate');

