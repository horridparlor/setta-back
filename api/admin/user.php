<?php

use system\Database;
use system\AccessBlock;
use system\StandardType;
use system\SqlComparison;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include "../../system/sql/selectUser.php";
include("../../system/AccessBlock.php");

function getUser(Database $database): string {
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized();
    }
    $userId = $database->getIntParam('userId', $user->getId());
    if ($userId != $user->getId() && !$user->isAdmin()) {
        return $database->responseUnauthorized();
    }
    $sql = SELECT_USER . <<<SQL
        WHERE user.id = :userId
    SQL;
    $replacements = array(
        'userId' => ['value' => $userId, 'type' => PDO::PARAM_INT]
    );
    $user = $database->queryWithDecode($sql, USER_COLUMNS_TO_DECODE, $replacements);
    if (!$user) {
        return $database->responseNotFound();
    }

    return $database->responseSuccess(array(
        'user' => $user[0]
    ));
}

function createNewRole(array $accessRights, Database $database): int {

}

function postUser(Database $database): string
{
    $uniqueUsernameSql = <<<SQL
        SELECT :comparedValue
        FROM user
        WHERE username = :comparedValue
    SQL;
    $roleExistsSql = <<<SQL
        SELECT :comparedValue
        FROM DUAL
        WHERE NOT EXISTS (
            SELECT id
            FROM userRole
            WHERE id = :comparedValue
        )
    SQL;

    $requiredParams = array(
        array(
          'param' => 'username',
          'type' => StandardType::STRING,
          'unique' => new SqlComparison($uniqueUsernameSql)
        ),
        array(
            'param' => 'password',
            'type' => StandardType::STRING
        ),
        array(
            'param' => 'isActive',
            'type' => StandardType::BOOLEAN,
            'required' => false
        ),
        array(
            'param' => 'roleId',
            'type' => StandardType::NUMBER,
            'exists' => new SqlComparison($roleExistsSql),
            'option' => array(
                'param' => 'accessRights',
            )
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }

    $username = $database->getStringParam('username');
    $password = $database->getStringParam('password');
    $passwordHash = password_hash($password, PASSWORD_DEFAULT);

    $firstname = $database->getStringParam('firstname');
    $lastname = $database->getStringParam('lastname');
    $penName = $database->getStringParam('penName');
    $email = $database->getStringParam('email');
    $phoneNumber = $database->getStringParam('phoneNumber');
    $isActive = $database->getBooleanParam('isActive', true);
    $roleId = $database->getIntParam('roleId');
    $accessRights = $database->getArrayParam('accessRights');
    if ($roleId = null) {
        $roleId = createNewRole($accessRights, $database);
    }
    $sql = <<<SQL
        INSERT INTO user (
            username,
            passwordHash,
            firstname,
            lastname,
            penName,
            email,
            phoneNumber,
            isActive,
            roleId
        ) VALUES (
            :username,
            :passwordHash, 
            :firstname,
            :lastname,
            :penName,
            :email,
            :phoneNumber,
            :isActive,
            :roleId
        )
    SQL;
    $replacements = array(
        'username' => ['value' => $username, 'type' => PDO::PARAM_STR],
        'passwordHash' => ['value' => $passwordHash, 'type' => PDO::PARAM_STR],
        'firstname' => ['value' => $firstname, 'type' => PDO::PARAM_STR],
        'lastname' => ['value' => $lastname, 'type' => PDO::PARAM_STR],
        'penName' => ['value' => $penName, 'type' => PDO::PARAM_STR],
        'email' => ['value' => $email, 'type' => PDO::PARAM_STR],
        'phoneNumber' => ['value' => $phoneNumber, 'type' => PDO::PARAM_STR],
        'isActive' => ['value' => $isActive, 'type' => PDO::PARAM_BOOL],
        'roleId' => ['value' => $roleId, 'type' => PDO::PARAM_INT],
    );
    $database->query($sql, $replacements);
    $result = $database->query('SELECT LAST_INSERT_ID() userId;');

    return $database->responseSuccess(array(
        'userId' => $result[0]['userId'],
    ));
}

$database = new Database();
$database->handleRequest('getUser', 'postUser');
