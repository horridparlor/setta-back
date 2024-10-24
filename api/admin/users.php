<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include "../../system/sql/selectUser.php";

function getUsers(Database $database): string {
    $user = $database->getUser();
    if (!$user || !$user->isAdmin()) {
        return $database->responseUnauthorized();
    }
    $sql = SELECT_USER;
    $users = $database->queryWithDecode($sql, USER_COLUMNS_TO_DECODE);

    return $database->responseSuccess(array(
        'countOfUsers' => sizeof($users),
        'users' => $users
    ));
}

$database = new Database();
$database->handleRequest('getUsers');
