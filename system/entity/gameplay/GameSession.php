<?php

namespace System\Entity\Gameplay;

use system\Database;

class GameSession {
    private int $id;
    private bool $isLookingForPlayers;

    public function __construct(int $id, bool $isLookingForPlayers) {
       $this->id = $id;
       $this->isLookingForPlayers = $isLookingForPlayers;
    }

    static public function fromQuery(string $sql, array $replacements, Database $database, bool $doDebug = false): GameSession|null {
        $gameSession = $database->query(SELECT_GAME_SESSION .  $sql, $replacements, $doDebug);
        if (empty($gameSession)) {
            return null;
        }
        return new GameSession(
            intval($gameSession[0]['id']),
            boolval($gameSession[0]['isLookingForPlayers']),
        );
    }

    public function getId(): int {
        return $this->id;
    }

    public function getIsLookingForPlayers(): int {
        return $this->isLookingForPlayers;
    }
}