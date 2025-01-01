<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include("../../system/sql/selectExpansion.php");

function getExpansions(Database $database): string
{
    $user = $database->getUser();
    $sql = SELECT_EXPANSION_SQL;
    $replacements = array();
    if (!$user) {
       $sql .= <<<SQL
            WHERE (
                isReleasedForGame = 1
            )
    SQL;
    } else if ($user->isSuperAdmin()) {
        $sql .= <<<SQL
            WHERE (
                isReleasedForGame = 1
                OR ownerId = 0
                OR ownerId = :userId
            )
    SQL;
    $replacements['userId'] = ['value' => $user ? $user->getId() : 0, 'type' => PDO::PARAM_INT];
    }
    $expansions = $database->query($sql, $replacements);
    return $database->responseSuccess(array(
        'countOfExpansions' => count($expansions),
        'expansions' => $expansions,
    ));
}

$database = new Database();
$database->handleRequest('getExpansions');

