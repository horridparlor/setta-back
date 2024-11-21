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
include("../../system/util/accessRights.php");

function createNewRole(User $user, string|null $roleName, int|null &$roleId, stdClass $accessRights, Database $database): string|null {
    $error = canGiveRole($user, $accessRights, $database);
    if ($error) {
        return $error;
    }

    $roleId = $database->getInsertId();
    return null;
}

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
    $user = $database->getUser();
    if (!$user || !$user->canManageUsers()) {
        return $database->responseUnauthorized($user?->getError());
    }
    $requiredParams = array(
        array(
          'param' => 'name',
          'type' => StandardType::STRING,
          'unique' => new SqlComparison(NEW_ROLE_NAME_SQL)
        ),
        getAccessRightsMissingParams()
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $roleName = $database->getStringParam('name');
    $accessRights = $database->getObjectParam('accessRights');
    $error = canGiveRole($user, $accessRights, $database);
    if ($error) {
        return $error;
    }
    $sql = <<<SQL
        INSERT INTO userRole (
            name,
            accessRights
        ) VALUES (
            :roleName,
            :accessRights 
        )
    SQL;
    $replacements = array(
        'roleName' => ['value' => $roleName, 'type' => PDO::PARAM_STR],
        'accessRights' => ['value' => json_encode($accessRights), 'type' => PDO::PARAM_STR]
    );
    $database->query($sql, $replacements);

    return $database->responseSuccess(array(
        'roleId' => $database->getInsertId()
    ));
}

function putRole(Database $database): string {
    $user = $database->getUser();
    if (!$user || !$user->canManageUsers()) {
        return $database->responseUnauthorized($user?->getError());
    }
    $requiredParams = array(
        array(
          'param' => 'roleId',
          'type' => StandardType::ID,
          'exists' => new SqlComparison(ROLE_EXISTS_SQL)
        ),
        array(
          'param' => 'name',
          'type' => StandardType::STRING,
          'unique' => new SqlComparison(UNIQUE_ROLE_NAME_SQL, UNIQUE_ROLE_NAME_REPLACEMENTS, $database->getRequestData())
        ),
        getAccessRightsMissingParams()
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $roleId = $database->getIntParam('roleId');
    $roleName = $database->getStringParam('name');
    $accessRights = $database->getObjectParam('accessRights');
    $error = canAlterRoleRights($user, $roleId, $accessRights, $database);
    if ($error) {
        return $error;
    }
    $sql = <<<SQL
        UPDATE userRole
        SET
            name = :roleName,
            accessRights = :accessRights
        WHERE id = :roleId
    SQL;
    $replacements = array(
        'roleId' => ['value' => $roleId, 'type' => PDO::PARAM_INT],
        'roleName' => ['value' => $roleName, 'type' => PDO::PARAM_STR],
        'accessRights' => ['value' => json_encode($accessRights), 'type' => PDO::PARAM_STR]
    );
    $database->query($sql, $replacements);
    return $database->responseSuccess(array(
        'roleId' => $roleId
    ));
}

function deleteRole(Database $database): string {
    $user = $database->getUser();
    if (!$user || !$user->canManageUsers()) {
        return $database->responseUnauthorized($user?->getError());
    }
    $requiredParams = array(
        array(
          'param' => 'roleId',
          'type' => StandardType::ID,
          'cascade' => new SqlComparison(ROLE_CASCADE_SQL)
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $roleId = $database->getIntParam('roleId');
    $sql = <<<SQL
        DELETE
        FROM userRole
        WHERE id = :roleId
    SQL;
    $replacements = array(
        'roleId' => ['value' => $roleId, 'type' => PDO::PARAM_INT]
    );
    $database->query($sql, $replacements);
    return $database->responseSuccess(array(
        'roleId' => $roleId
    ));
}

$database = new Database();
$database->handleRequest('getRole', 'postRole', 'putRole', 'deleteRole');
