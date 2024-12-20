<?php

use system\Database;
use system\AccessBlock;
use system\StandardType;
use system\SqlComparison;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include("../../system/AccessBlock.php");
include("../../system/sql/selectDecklist.php");


function getDecklists(Database $database): string {
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized($user?->getError());
    };
    $sql = SELECT_DECKLIST . <<<SQL
        WHERE decklist.ownerId = :ownerId
        AND decklist.isDeleted = 0
    SQL;
    $replacements = array(
        'ownerId' => ['value' => $user->getId(), 'type' => PDO::PARAM_INT]
    );
    $decklists = $database->queryWithDecode($sql, DECKLIST_COLUMNS_TO_DECODE, $replacements);
    return $database->responseSuccess(array(
        'countOfDecklists' => count($decklists),
        'decklists' => $decklists
    ));
}

$database = new Database();
$database->handleRequest('getDecklists');
