<?php

use system\Database;
use system\AccessBlock;
use system\StandardType;
use system\SqlComparison;
use system\User;
use System\Entity\Gameplay\GameSession;
use System\Entity\Gameplay\Player;

header('Content-Type: application/json');

include("../../../system/Database.php");
include("../../../system/User.php");
include("../../../system/AccessBlock.php");
include("../../../system/entity/gameplay/GameSession.php");
include("../../../system/sql/gameplay/selectGameSession.php");
include("../../../system/sql/selectDecklist.php");
include("../../../system/sql/selectFormat.php");
include("../../../system/sql/selectDeckBlock.php");
include("../../../system/sql/gameplay/selectCardInGame.php");
include("../../../system/entity/gameplay/Player.php");

function findMatch(Database $database): string {
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized($user?->getError());
    }
    $decklistExistsReplacements = array(
      'ownerId' => ['value' => $user->getId(), 'type' => PDO::PARAM_INT],
      'formatId' => ['value' => '$formatId', 'type' => PDO::PARAM_INT]
    );
    $requiredParams = array(
        array(
            'param' => 'formatId',
            'type' => StandardType::ID,
            'exists' => new SqlComparison(FORMAT_EXISTS_SQL)
        ),
        array(
            'param' => 'decklistId',
            'type' => StandardType::ID,
            'exists' => new SqlComparison(VALID_OWNED_DECKLIST_EXISTS_SQL, $decklistExistsReplacements, $database->getRequestData())
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $formatId = $database->getIntParam('formatId', 1);
    $decklistId = $database->getIntParam('decklistId');
    $player = new Player($user, $formatId, $decklistId);
    return $database->responseSuccess(findGameSession($player, $database));
}


function findGameSession(Player $player, Database $database): array {
    $gameSession = findExistingGameSession($player, $database)
        ?? joinGameSession($player, $database)
        ?? createNewGameSession($player, $database);
    $isLookingForPlayers = boolval($gameSession->getIsLookingForPlayers());
    $player->setGameSessionId($gameSession->getId());
    $cardsInHand = $player->getCardsInHand($database);

    return array(
        'gameSessionId' => $gameSession->getId(),
        'isLookingForPlayers' => $isLookingForPlayers,
        'cardsInHand' => $isLookingForPlayers ? array() : $cardsInHand
    );
}

function findExistingGameSession(Player $player, Database $database): GameSession|null {
    $sql = <<<SQL
        JOIN playerInGame player
        ON player.gameId = game.id
        WHERE player.playerId = :userId
        AND game.formatId = :formatId
        AND game.isOver = 0  
    SQL;
    return GameSession::fromQuery($sql, $player->getUser()->getReplacements('userId', ['formatId' => $player->getFormatId()]), $database);
}

function joinGameSession(Player $player, Database $database): GameSession|null {
    $sql = <<<SQL
        WHERE game.isLookingForPlayers = 1
        AND formatId = :formatId
    SQL;
    $replacements = array(
        'formatId' => ['value' => $player->getFormatId(), 'type' => PDO::PARAM_INT]
    );
    $gameSession = GameSession::fromQuery($sql, $replacements, $database);
    if (!$gameSession) {
        return null;
    }
    joinPlayerToGame($player, 2, $gameSession->getId(), $database);
    return findExistingGameSession($player, $database);
}

function createNewGameSession(Player $player, Database $database): GameSession|null {
    $sql = <<<SQL
       INSERT INTO gameSession(
        formatId,
        startingPlayer,
        turnPlayer
       ) VALUES (
        :formatId,
        :startingPlayer,
        :startingPlayer
       ) 
    SQL;
    $replacements = array(
        'formatId' => ['value' => $player->getFormatId(), 'type' => PDO::PARAM_INT],
        'startingPlayer' => ['value' => rand(1, 2), 'type' => PDO::PARAM_INT]
    );
    $database->query($sql, $replacements);
    $gameSessionId = $database->getInsertId();
    joinPlayerToGame($player, 1, $gameSessionId, $database);

    return findExistingGameSession($player, $database);
}

function joinPlayerToGame(Player $player, int $index, int $gameSessionId, Database $database): void {
    $sql = <<<SQL
        INSERT INTO playerInGame(
        playerId,
        gameId,
        `index`,
        decklistJson
       ) VALUES (
        :playerId,
        :gameId,
        :index,
        :decklistJson
       );
    SQL;
    if ($index == 2) {
        $sql .= <<<SQL
            UPDATE gameSession game
            SET 
                isLookingForPlayers = 0,
                updatedAt = NOW()
            WHERE game.id = :gameId;
        SQL;
    }
    $replacements = array(
        'playerId' => ['value' => $player->getId(), 'type' => PDO::PARAM_INT],
        'gameId' => ['value' => $gameSessionId, 'type' => PDO::PARAM_INT],
        'index' => ['value' => $index, 'type' => PDO::PARAM_INT],
        'decklistJson' => ['value' => json_encode($player->getDecklistJson($database)), 'type' => PDO::PARAM_STR]
    );
    $database->query($sql, $replacements);
    spawnDecklistToGame($player, $gameSessionId, $database);
}

function spawnDecklistToGame(Player $player, int $gameSessionId, Database $database): void {
    $allCards = array();
    $deckmasterCards = array();
    $mainCards = array();
    $extraCards = array();
    foreach ($player->getDecklistJson($database) as $cardInDeck) {
        switch ($cardInDeck->deckBlock) {
            case DeckBlock::DECK_MASTER->value:
                $source = &$deckmasterCards;
                break;
            case DeckBlock::EXTRA->value:
                $source = &$extraCards;
                break;
            default:
                $source = &$mainCards;
                break;
        }
        for ($i = 0; $i < $cardInDeck->copies; $i++) {
            $source []= $cardInDeck->cardId;
        }
    }
    shuffle($deckmasterCards);
    shuffle($mainCards);
    $handCards = array_splice($mainCards, -4);
    shuffle($extraCards);
    $index = 0;
    foreach ($deckmasterCards as $cardId) {
        $card = new stdClass();
        $card->cardId = $cardId;
        $card->zoneId = 3;
        $card->index = $index;
        $allCards[] = $card;
        $index += 1;
    }
    $index = 0;
    foreach ($mainCards as $cardId) {
        $card = new stdClass();
        $card->cardId = $cardId;
        $card->zoneId = 1;
        $card->index = $index;
        $allCards[] = $card;
        $index += 1;
    }
    $index = 0;
    foreach ($handCards as $cardId) {
        $card = new stdClass();
        $card->cardId = $cardId;
        $card->zoneId = 4;
        $card->index = $index;
        $allCards[] = $card;
        $index += 1;
    }
    $index = 0;
    foreach ($extraCards as $cardId) {
        $card = new stdClass();
        $card->cardId = $cardId;
        $card->zoneId = 2;
        $card->index = $index;
        $allCards[] = $card;
        $index += 1;
    }
    $insertionsSql = array();
    foreach ($allCards as $card) {
        $insertionsSql[] = sprintf(
            '(%s, %s, %s, %s, %s, %s)',
            $card->cardId,
            $gameSessionId,
            $player->getId(),
            $player->getId(),
            $card->zoneId,
            $card->index
        );
    }
    $sql = <<<SQL
        INSERT INTO cardInGame(
            cardId,
            gameId,
            ownerId,
            controllerId,
            zoneId,
            `index`
        ) VALUES
    SQL . implode(',', $insertionsSql);
    $database->query($sql, []);
}

$database = new Database();
$database->handleRequest(null, 'findMatch');
