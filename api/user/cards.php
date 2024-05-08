<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");

function getCards(Database $database): string
{
    $user = $database->getUser();

    $sql = <<<SQL
        SELECT
            card.id cardId,
            userId ownerId,
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
        JOIN user
            ON user.id = card.userId
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
    $replacements = array();
    if (!$user) {
        $sql .= <<<SQL
            AND user.isAdmin = 1
        SQL;
    } elseif (!$user->isAdmin()) {
        $sql .= <<<SQL
            AND (
                user.isAdmin = 1
                OR user.id = :userId
            )
        SQL;
        $replacements['userId'] = ['value' => $user->getId(), 'type' => PDO::PARAM_INT];
    }
    $cards = $database->query($sql, $replacements);
    return $database->responseSuccess(array(
        'countOfCards' => count($cards),
        'cards' => $cards,
    ));
}

$database = new Database();
$database->handleRequest('getCards');

