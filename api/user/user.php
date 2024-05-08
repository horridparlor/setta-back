<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");

function postUser(Database $database): string
{
    $username = $database->getStringParam('username');
    $email = $database->getStringParam('email');
    $firstname = $database->getStringParam('firstname');
    $lastname = $database->getStringParam('lastname');
    $password = $database->getStringParam('password');
    $passwordHash = password_hash($password, PASSWORD_DEFAULT);
    $sql = <<<SQL
        INSERT INTO user (
            username,
            email,
            firstname,
            lastname,
            passwordHash,
            isAdmin
        ) VALUES (
            :username,
            :email,
            :firstname,
            :lastname,
            :passwordHash,
            0
        )
    SQL;
    $replacements = array(
        'username' => ['value' => $username, 'type' => PDO::PARAM_STR],
        'email' => ['value' => $email, 'type' => PDO::PARAM_STR],
        'firstname' => ['value' => $firstname, 'type' => PDO::PARAM_STR],
        'lastname' => ['value' => $lastname, 'type' => PDO::PARAM_STR],
        'passwordHash' => ['value' => $passwordHash, 'type' => PDO::PARAM_STR],
    );
    $database->query($sql, $replacements);
    $result = $database->query('SELECT LAST_INSERT_ID() userId;');

    return $database->responseSuccess(array(
        'userId' => $result[0]['userId'],
    ));
}

$database = new Database();
$database->handleRequest(null, 'postUser');

