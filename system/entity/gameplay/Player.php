<?php

namespace System\Entity\Gameplay;

use system\Database;
use system\User;
use PDO;

include("../../../system/sql/gameplay/selectPlayerInGame.php");

const ZONE_ID_DECK = 1;
const ZONE_ID_LOVERS = 2;
const ZONE_ID_QUEEN = 3;
const ZONE_ID_HAND = 4;
const ZONE_ID_FIELD = 5;
const ZONE_ID_BACKROW = 6;
const ZONE_ID_FRIEND_ZONE = 7;

class Player {
    private User $user;
    private int $formatId;
    private array $decklist;
    private int|null $gameId;
    private int $lifePoints;
    private array $cardsInDeck;
    private array $cardsInLoverDeck;
    private array $cardsInQueenZone;
    private array $cardsInHand;
    private array $cardsInField;
    private array $cardsInBackrow;
    private array $cardsInFriendZone;

    public function __construct(User $user, Database $database, int $formatId = 1, int|string $decklist = 0, int $gameSessionId = 0, int $lifePoints = 0) {
        $this->user = $user;
        $this->formatId = $formatId;
        $this->decklist = is_int($decklist) ? $this->pullDecklistJson($decklist, $database) : json_decode($decklist);
        $this->gameId = $gameSessionId;
        $this->lifePoints = $lifePoints;
        $this->cardsInDeck = $this->pullCardsInZone(ZONE_ID_DECK, $database);
        $this->cardsInLoverDeck = $this->pullCardsInZone(ZONE_ID_LOVERS, $database);
        $this->cardsInQueenZone = $this->pullCardsInZone(ZONE_ID_QUEEN, $database);
        $this->cardsInHand = $this->pullCardsInZone(ZONE_ID_HAND, $database);
        $this->cardsInField = $this->pullCardsInZone(ZONE_ID_FIELD, $database);
        $this->cardsInBackrow = $this->pullCardsInZone(ZONE_ID_BACKROW, $database);
        $this->cardsInFriendZone = $this->pullCardsInZone(ZONE_ID_FRIEND_ZONE, $database);
    }

    static public function fromQuery(string $sql, array $replacements, Database $database, bool $doDebug = false): Player|null {
        $player = $database->query(SELECT_PLAYER_IN_GAME_SQL .  $sql, $replacements, $doDebug);
        if (empty($player)) {
            return null;
        }
        $player = $player[0];
        return new Player(
            $database->findUser(intval($player['userId'])),
            $database,
            intval($player['formatId']),
            strval($player['decklistJson']),
            intval($player['gameId']),
            intval($player['lifePoints'])
        );
    }

    static public function fromId(int $playerId, Database $database, bool $doDebug = false): Player|null {
        $sql = <<<SQL
            AND player.id = :playerId
        SQL;
        $replacements = [
            'playerId' => ['value' => $playerId, 'type' => PDO::PARAM_INT]
        ];
        return self::fromQuery($sql, $replacements, $database, $doDebug);
    }

    public function getFormatId(): int {
        return $this->formatId;
    }

    public function getDecklist(): array {
        return $this->decklist;
    }

    public function setGameId(int $gameId): void {
        $this->gameId = $gameId;
    }

    public function getGameId(): int {
        return $this->gameId;
    }

    public function getUser(): User {
        return $this->user;
    }

    public function getUserId(): int {
        return $this->user->getId();
    }

    public function pullDecklistJson(int $decklistId, Database $database): array {
        $replacements = array(
            'decklistId' => ['value' => $decklistId, 'type' => \PDO::PARAM_INT]
        );
        return json_decode($database->query(SELECT_DECKLIST_CARDS, $replacements)[0]['cards']);
    }

    public function getReplacements(array $additionalKeys = array()): array {
        $replacements = array(
            'gameId' => ['value' => $this->gameId, 'type' => \PDO::PARAM_INT],
            'userId' => ['value' => $this->getUserId(), 'type' => \PDO::PARAM_INT]
        );
        foreach ($additionalKeys as $key => $value) {
            $replacements[$key] = ['value' => $value, 'type' => \PDO::PARAM_INT];
        }
        return $replacements;
    }

    public function pullCardsInZone(int $zoneId, Database $database): array {
        $sql = SELECT_CARD_IN_GAME . <<<SQL
            AND zone.id = :zoneId
            AND card.controllerId = :userId
        SQL;
        $replacements = $this->getReplacements(['zoneId' => $zoneId]);
        return $database->query($sql, $replacements);
    }

    public function output(int $ownerId): array {
        return array(
            'metaData' => $this->getMetaData(),
            'zones' => $this->getZones($ownerId != $this->getUserId()),
        );
    }

    public function getMetaData(): array {
        return array(
            'userId' => $this->user->getId(),
            'name' => $this->user->getDisplayName(),
            'lifePoints' => $this->lifePoints
        );
    }

    public function getZones(bool $isOpponent): array {
        return array(
            'deck' => $this->showZone($this->cardsInDeck, true),
            'lovers' => $this->showZone($this->cardsInLoverDeck, $isOpponent),
            'queenZone' => $this->showZone($this->cardsInQueenZone),
            'hand' => $this->showZone($this->cardsInHand, $isOpponent),
            'field' => $this->showZone($this->cardsInField),
            'backrow' => $this->showZone($this->cardsInBackrow, $isOpponent),
            'friendZone' => $this->showZone($this->cardsInFriendZone),
        );
    }

    public function showZone(array $cards, bool $doHide = false): array {
        $zone = array(
            'countOfCards' => sizeof($cards),
        );
        if (!$doHide) {
            $zone['cards'] = $cards;
        }
        return $zone;
    }
}
