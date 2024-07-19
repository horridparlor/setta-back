<?php

use system\Database;
use system\AccessBlock;
use system\StandardType;
use system\SqlComparison;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include("../../system/AccessBlock.php");

function deleteDecklist(Database $database): string
{
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized();
    }

    $existsSql = <<<SQL
        SELECT :comparedValue, 'Decklist' entityType
        FROM DUAL
        WHERE NOT EXISTS (
            SELECT deck.id
            FROM decklist deck
            WHERE deck.id = :comparedValue
            AND deck.ownerId = :ownerId 
        )
    SQL;
    $existsReplacements = array(
        'ownerId' => ['value' => $user->getId(), 'type' => PDO::PARAM_INT],
    );

    $requiredParams = array(
        array(
          'param' => 'deckId',
          'type' => StandardType::ID,
          'exists' => new SqlComparison($existsSql, $existsReplacements)
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }

    $deckId = $database->getIntParam('deckId');

    return $database->responseSuccess(array(
        'deckId' => $deckId,
    ));
}

$database = new Database();
$database->handleRequest(null, null, null, 'deleteDecklist');
