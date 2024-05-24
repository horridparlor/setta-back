<?php

use system\Database;
use system\AccessBlock;
use system\StandardType;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include("../../system/AccessBlock.php");

function authenticate(Database $database): string
{
    $requiredParams = array(
      array(
          'param' => 'cardId',
          'type' => StandardType::NUMBER
      )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $user = $database->getUser();
    $cardId = $database->getIntParam('cardId');
    if (!$user) {
        return $database->responseUnauthorized();
    }

    return $database->responseSuccess(array(
        'cardId' => $cardId,
    ));
}

$database = new Database();
$database->handleRequest(null, 'authenticate');

