<?php

use system\Database;
use system\AccessBlock;
use system\StandardType;
use system\SqlComparison;
use system\User;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include("../../system/AccessBlock.php");
include "../../system/sql/selectRole.php";

function getRole(Database $database): string {
    $user = $database->getUser();
    if (!$user || !$user->canManageUsers()) {
        return $database->responseUnauthorized($user?->getError());
    }
    $requiredParams = array(
        array(
          'param' => 'roleId',
          'type' => StandardType::ID,
          'exists' => new SqlComparison(ROLE_EXISTS_SQL)
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $roleId = $database->getIntParam('roleId');
    $sql = SELECT_ROLE . <<<SQL
        WHERE role.id = :roleId
    SQL;
    $replacements = array(
        'roleId' => ['value' => $roleId, 'type' => PDO::PARAM_INT]
    );
    $role = $database->queryWithDecode($sql, ROLE_COLUMNS_TO_DECODE, $replacements);

    return $database->responseSuccess($role[0]);
}

function postRole(Database $database): string {
    $roleId = $database->getIntParam('roleId');
    return $database->responseSuccess(array(
        'roleId' => $roleId
    ));
}

function putRole(Database $database): string {
    $roleId = $database->getIntParam('roleId');
    return $database->responseSuccess(array(
        'roleId' => $roleId
    ));
}

function deleteRole(Database $database): string {
    $roleId = $database->getIntParam('roleId');
    return $database->responseSuccess(array(
        'roleId' => $roleId
    ));
}

$database = new Database();
$database->handleRequest('getRole', 'postRole', 'putRole', 'deleteRole');
