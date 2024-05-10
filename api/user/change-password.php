<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");

function changePassword(Database $database): string
{
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized();
    }

    $password = $database->getStringParam('password');
    $passwordHash = password_hash($password, PASSWORD_DEFAULT);
    $sql = <<<SQL
        UPDATE user
        SET passwordHash = :passwordHash
        WHERE id = :userId
    SQL;
    $replacements = array(
        'passwordHash' => ['value' => $passwordHash, 'type' => PDO::PARAM_STR],
        'userId' => ['value' => $user->getId(), 'type' => PDO::PARAM_INT],
    );
    $database->query($sql, $replacements);
    return $database->responseSuccess(array(
        'status' => 'Password changed',
    ));
}

$database = new Database();
$database->handleRequest(null, 'changePassword');

