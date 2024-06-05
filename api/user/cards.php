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
        WHERE card.isDeleted = 0
    SQL;
    $replacements = array();
    if (!$user) {
        $sql .= <<<SQL
            AND (expansionOwner.isAdmin = 1 AND expansion.isReleased = 1)
            GROUP BY card.errataOfId
            HAVING MAX(created_at);
        SQL;
    } elseif (!$user->isAdmin()) {
        $sql .= <<<SQL
            AND (
                (expansionOwner.isAdmin = 1 AND expansion.isReleased = 1 )
                OR cardOwner.id = :userId
                OR expansionOwner.id = :userId
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

