<?php

namespace System\Entity\Gameplay;

use system\Database;
use system\User;

const ZONE_ID_HAND = 4;

class Player {
    private User $user;
    private int $formatId;
    private int $decklistId;
    private int|null $gameSessionId;

    public function __construct(User $user, int $formatId = 1, int $decklistId = 0, int $gameSessionId = null) {
        $this->user = $user;
        $this->formatId = $formatId;
        $this->decklistId = $decklistId;
        $this->gameSessionId = $gameSessionId;
    }

    public function getFormatId(): int {
        return $this->formatId;
    }

    public function getDecklistId(): int {
        return $this->decklistId;
    }

    public function setGameSessionId(int $gameSessionId): void {
        $this->gameSessionId = $gameSessionId;
    }

    public function getGameSessionId(): int {
        return $this->gameSessionId;
    }

    public function getUser(): User {
        return $this->user;
    }

    public function getId(): int {
        return $this->user->getId();
    }

    public function getDecklistJson(Database $database): array {
        $replacements = array(
            'decklistId' => ['value' => $this->decklistId, 'type' => \PDO::PARAM_INT]
        );
        return json_decode($database->query(SELECT_DECKLIST_CARDS, $replacements)[0]['cards']);
    }

    public function getReplacements(array $additionalKeys = array()): array {
        $replacements = array(
            'gameId' => ['value' => $this->gameSessionId, 'type' => \PDO::PARAM_INT],
            'playerId' => ['value' => $this->getId(), 'type' => \PDO::PARAM_INT]
        );
        foreach ($additionalKeys as $key => $value) {
            $replacements[$key] = ['value' => $value, 'type' => \PDO::PARAM_INT];
        }
        return $replacements;
    }

    public function getCardsInHand(Database $database): array {
        $sql = SELECT_CARD_IN_GAME . <<<SQL
            AND zone.id = :zoneId
            AND card.controllerId = :playerId
        SQL;
        $replacements = $this->getReplacements(['zoneId' => ZONE_ID_HAND]);
        return $database->query($sql, $replacements);
    }
}
