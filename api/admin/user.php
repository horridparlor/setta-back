<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include "../../system/sql/selectUser.php";

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

function postUser(Database $database): string
{
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
