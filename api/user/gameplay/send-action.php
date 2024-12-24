<?php

use system\Database;
use system\AccessBlock;
use system\StandardType;
use system\SqlComparison;

header('Content-Type: application/json');

include("../../../system/Database.php");
include("../../../system/User.php");
include("../../../system/AccessBlock.php");

function sendAction(Database $database): string {
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized($user?->getError());
    }

    return $database->responseSuccess(array(
       'gameSessionId' => 144
    ));
}


$database = new Database();
$database->handleRequest(null, 'sendAction');
