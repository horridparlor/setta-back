<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include("../../system/sql/selectCard.php");

function getCards(Database $database): string
{
    $user = $database->getUser();

    $sql = SELECT_CARD . <<<SQL
        LEFT JOIN (
            SELECT id, errataOfId
            FROM card
            WHERE created_at IN (
                SELECT MAX(created_at)
                FROM card
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
    $cards = $database->query($sql, $replacements);
    return $database->responseSuccess(array(
        'countOfCards' => count($cards),
        'cards' => $cards,
    ));
}

$database = new Database();
$database->handleRequest('getCards');

