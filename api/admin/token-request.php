<?php

use system\Database;
use system\AccessBlock;
use system\StandardType;
use system\SqlComparison;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include("../../system/AccessBlock.php");
include "../../system/sql/selectTokenRequest.php";
include "../../system/sql/selectUser.php";

function postTokenRequest(Database $database): string {
    $user = $database->getUser();
    $userId = $database->getIntParam('userId', $user?->getId());
    if (!$user || !$user->canManageUsersImageGeneration($userId)) {
        return $database->responseUnauthorized($user?->getError());
    }
    $requiredParams = array(
        array(
            'param' => 'userId',
            'type' => StandardType::ID,
            'exists' => new SqlComparison(USER_EXISTS_SQL),
            'required' => false
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $editedUser = $database->findUser($userId);
    if ($editedUser->hasUnlimitedTokens()) {
        return $database->responseForbidden(array(
            'error' => 'User has unlimited tokens'
        ));
    }
    $sql = <<<SQL
        DELETE
        FROM tokenRequest
        WHERE userId = :userId;
        
        INSERT INTO tokenRequest (userId)
        VALUES (:userId); 
    SQL;
    $replacements = array(
        'userId' => ['value' => $userId, 'type' => PDO::PARAM_INT]
    );
    $database->query($sql, $replacements);

    return $database->responseSuccess(array(
        'tokenRequestId' => $database->getInsertId()
    ));
}

function deleteTokenRequest(Database $database): string {
    $user = $database->getUser();
    $userId = $database->getIntParam('userId', $user?->getId());
    if (!$user || !$user->canManageUsersImageGeneration($userId)) {
        return $database->responseUnauthorized($user?->getError());
    }
    $requiredParams = array(
        array(
            'param' => 'userId',
            'type' => StandardType::ID,
            'required' => false
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $sql = <<<SQL
        DELETE
        FROM tokenRequest
        WHERE userId = :userId;
    SQL;
    $replacements = array(
        'userId' => ['value' => $userId, 'type' => PDO::PARAM_INT]
    );
    $database->query($sql, $replacements);

    return $database->responseSuccess(array(
        'userId' => $userId
    ));
}

$database = new Database();
$database->handleRequest(null, 'postTokenRequest', null, 'deleteTokenRequest');
