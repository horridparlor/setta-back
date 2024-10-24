<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");

function getUsers(Database $database): string {
    $user = $database->getUser();
    if (!$user || !$user->isAdmin()) {
        return $database->responseUnauthorized();
    }
    $sql = <<<SQL
        SELECT
            user.id,
            username,
            firstname,
            lastname,
            penName,
            email,
            phoneNumber,
            isActive,
            roleId,
            accessRights,
            CASE
                WHEN tr.id IS NOT NULL THEN JSON_OBJECT(
                    'id', tr.id,
                    'userId', tr.userId,
                    'cardsInQueue', tr.cardsInQueue,
                    'createdAt', tr.createdAt
                )
                ELSE null
            END AS tokenRequest
        FROM user
        JOIN userRole role
            ON role.id = user.roleId
        LEFT JOIN tokenRequest tr
            ON tr.userId = user.id;
    SQL;
    $users = $database->query($sql);
    foreach ($users as &$user) {
        $user['accessRights'] = json_decode($user['accessRights']);
        $user['tokenRequest'] = $user['tokenRequest'] ? json_decode($user['tokenRequest']) : null;
    }

    return $database->responseSuccess(array(
        'users' => $users
    ));
}

$database = new Database();
$database->handleRequest('getUsers');
