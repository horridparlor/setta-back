<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");

function getExpansions(Database $database): string
{
    $sql = <<<SQL
        SELECT id, ownerId, name, releaseYear, isReleased
        FROM expansion
    SQL;
    $expansions = $database->query($sql);
    return $database->responseSuccess(array(
        'countOfExpansions' => count($expansions),
        'expansions' => $expansions,
    ));
}

$database = new Database();
$database->handleRequest('getExpansions');

