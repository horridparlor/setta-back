<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");

function getCards(Database $database): string
{
    $sql = <<<SQL
        SELECT
            card.id cardId,
            cardName,
            isAce,
            cardClass.name cardClass,
            cardType.name cardType,
            cardSubtype.name subtype,
            cardSupertype.name supertype,
            maximumPiece.name maximumPiece,
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
        JOIN cardClass
            ON cardClass.id = card.cardClassId
        JOIN cardType
            ON cardType.id = card.cardTypeId
        JOIN cardSubtype
            ON cardSubtype.id = card.subtypeId
        JOIN cardSupertype
            ON cardSupertype.id = card.supertypeId
        JOIN maximumPiece
            ON maximumPiece.id = card.maximumPieceId
        WHERE card.isDeleted = 0
    SQL;
    $cards = $database->query($sql);
    return $database->responseSuccess(array(
        'countOfCards' => count($cards),
        'cards' => $cards,
    ));
}

$database = new Database();
$database->handleRequest('getCards');

