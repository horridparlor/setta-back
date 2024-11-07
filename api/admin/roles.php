<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include "../../system/sql/selectRole.php";

function listRoles(Database $database): string {
    $user = $database->getUser();
    if (!$user || !$user->canManageUsers()) {
        return $database->responseUnauthorized($user?->getError());
    }
    $sql = SELECT_ROLE;
    $roles = $database->queryWithDecode($sql, ROLE_COLUMNS_TO_DECODE);

    return $database->responseSuccess(array(
        'countOfRoles' => sizeof($roles),
        'roles' => $roles
    ));
}

$database = new Database();
$database->handleRequest('listRoles');
