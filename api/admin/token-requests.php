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

function listTokenRequests(Database $database): string {
    $user = $database->getUser();
    if (!$user || !$user->canManageImageGeneration()) {
        return $database->responseUnauthorized($user?->getError());
    }
    $tokenRequests = $database->query(SELECT_TOKEN_REQUEST);

    return $database->responseSuccess(array(
        'countOfTokenRequests' => sizeof($tokenRequests),
        'tokenRequests' => $tokenRequests
    ));
}

$database = new Database();
$database->handleRequest('listTokenRequests');
