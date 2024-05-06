<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");

function getExpansions(Database $database): string
{
    $sql = <<<SQL
        SELECT id, name, releaseYear, isReleased
        from expansion
    SQL;
    $response = $database->query($sql);
    $expansions = [];
    foreach ($response as $expansion) {
        $expansions[$expansion['id']] = $expansion;
    }
    return $database->responseSuccess(array(
        'countOfExpansions' => count($response),
        'expansions' => $expansions,
    ));
}

$database = new Database();
$database->handleRequest('getExpansions');

