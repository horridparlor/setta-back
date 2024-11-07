<?php

use system\Database;
use system\AccessBlock;
use system\StandardType;
use system\SqlComparison;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include("../../system/AccessBlock.php");


function getDecklist(Database $database): string
{
    return "222";
}

function postDecklist(Database $database): string
{
    return "222";
}

function putDecklist(Database $database): string
{
    return "222";
}

function deleteDecklist(Database $database): string
{
    $deckId = $database->getIntParam('deckId');

    return $database->responseSuccess(array(
        'deckId' => $deckId,
    ));
}

$database = new Database();
$database->handleRequest('getDecklist', 'postDecklist', 'putDecklist', 'deleteDecklist');
