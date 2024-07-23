<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include("../../system/sql/selectCard.php");

function getCards(Database $database): string
{
    $user = $database->getUser();
    $isGame = $database->getBooleanParam('isGame');

    $sql = SELECT_CARD . <<<SQL
        LEFT JOIN (
            SELECT id, errataOfId
            FROM card
            WHERE created_at IN (
                SELECT MAX(errata.created_at)
                FROM card errata
                JOIN expansion
                    ON expansion.id = errata.expansionId
                WHERE errata.errataOfId = card.errataOfId
                AND expansion.isReleased = 1
                AND isDeleted = 0
                GROUP BY errataOfId
            )
        ) newestErrata ON newestErrata.errataOfId = card.errataOfId
        WHERE card.isDeleted = 0
        AND (
            newestErrata.id IS NULL
            OR expansion.isReleased = 0
            OR card.id = newestErrata.id
            OR card.ownerId = :userId
        )
    SQL;
    if ($isGame) {
        $sql .=  <<<SQL
            AND originalExpansion.isReleasedForGame = 1
        SQL;
    }
    $replacements = array(
        'userId' => ['value' => $user ? $user->getId() : 0, 'type' => PDO::PARAM_INT]
    );
    if (!$user) {
        $sql .= <<<SQL
            AND (expansionOwner.isAdmin = 1 AND expansion.isReleased = 1)
        SQL;
    } elseif (!$user->isAdmin()) {
        $sql .= <<<SQL
            AND (
                (expansionOwner.isAdmin = 1 AND expansion.isReleased = 1 )
                OR cardOwner.id = :userId
                OR expansionOwner.id = :userId
            )
        SQL;
    }
    $cards = array();
    $rawCards = $database->query($sql, $replacements);
    foreach ($rawCards as $card) {
        $card['cardEffects'] = json_decode($card['effectsJson']);
        unset($card['effectsJson']);
        $cards[] = $card;
    }
    return $database->responseSuccess(array(
        'countOfCards' => count($cards),
        'cards' => $cards,
    ));
}

$database = new Database();
$database->handleRequest('getCards');

