<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");

function getCards(Database $database): string
{
    $sql = <<<SQL
        SELECT
            id,
            cardName,
            isAce,
            cardClassId,
            cardTypeId,
            subtypeId,
            supertypeId,
            maximumPieceId,
            level,
            atk,
            def,
            primaryMaterialId,
            secondaryMaterialId,
            tertiaryMaterialId,
            costText,
            effectText,
            flavourText,
            countsAsId,
            artScale,
            artXOffset,
            artYOffset,
            nameSize,
            materialsSize,
            effectsSize,
            expansionId
        FROM card
    SQL;
    $response = $database->query($sql);
    $cards = [];
    foreach ($response as $card) {
        $cards[$card['id']] = $card;
    }
    return $database->responseSuccess(array(
        'countOfCards' => count($response),
        'cards' => $cards,
    ));
}

$database = new Database();
$database->handleRequest('getCards');

