<?php

namespace System\Entity\Gameplay;

use system\Database;
use system\User;
use PDO;

include("../../../system/sql/gameplay/selectPlayerInGame.php");

const ZONE_ID_HAND = 4;

class Player {
    private User $user;
    private int $formatId;
    private array $decklist;
    private int|null $gameId;

    public function __construct(User $user, Database $database, int $formatId = 1, int|string $decklist = 0, int $gameSessionId = null) {
        $this->user = $user;
        $this->formatId = $formatId;
        $this->decklist = is_int($decklist) ? $this->getDecklistJson($decklist, $database) : json_decode($decklist);
        $this->gameId = $gameSessionId;
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
            intval($player['gameId'])
        );
    }

    static public function fromId(int $playerId, Database $database, bool $doDebug = false): Player {
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

    public function getDecklistJson(int $decklistId, Database $database): array {
        $replacements = array(
            'decklistId' => ['value' => $decklistId, 'type' => \PDO::PARAM_INT]
        );
        return json_decode($database->query(SELECT_DECKLIST_CARDS, $replacements, true)[0]['cards']);
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

    public function getCardsInHand(Database $database): array {
        $sql = SELECT_CARD_IN_GAME . <<<SQL
            AND zone.id = :zoneId
            AND card.controllerId = :userId
        SQL;
        $replacements = $this->getReplacements(['zoneId' => ZONE_ID_HAND]);
        return $database->query($sql, $replacements);
    }

    public function output(): array {
        return array(
            'userId' => $this->user->getId(),
            'name' => $this->user->getDisplayName(),
        );
    }
}
