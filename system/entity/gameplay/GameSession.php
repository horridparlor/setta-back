<?php

namespace System\Entity\Gameplay;

use PDO;
use system\Database;

include("../../../system/entity/gameplay/Format.php");

class GameSession {
    private int $id;
    private Format $format;
    private int $startingPlayer;
    private int $turnPlayer;
    private int $turnNumber;
    private bool $isLookingForPlayers;
    private bool $isOver;
    private array $stack;
    private Player|null $playerOne;
    private Player|null $playerTwo;

    public function __construct(
        int $id,
        Format $format,
        int $startingPlayer,
        int $turnPlayer,
        int $turnNumber,
        bool $isLookingForPlayers,
        bool $isOver,
        array $stack,
        Player|null $playerOne,
        Player|null $playerTwo
    ) {
       $this->id = $id;
       $this->format = $format;
       $this->startingPlayer = $startingPlayer;
       $this->turnPlayer = $turnPlayer;
       $this->turnNumber = $turnNumber;
       $this->isLookingForPlayers = $isLookingForPlayers;
       $this->isOver = $isOver;
       $this->stack = $stack;
       $this->playerOne = $playerOne;
       $this->playerTwo = $playerTwo;
    }

    static public function fromQuery(string $sql, array $replacements, Database $database, bool $doDebug = false): GameSession|null {
        $gameSession = $database->query(SELECT_GAME_SESSION .  $sql, $replacements, $doDebug);
        if (empty($gameSession)) {
            return null;
        }
        $gameSession = $gameSession[0];
        return new GameSession(
            intval($gameSession['id']),
            Format::fromId(intval($gameSession['formatId']), $database),
            intval($gameSession['startingPlayer']),
            intval($gameSession['turnPlayer']),
            intval($gameSession['turnNumber']),
            boolval($gameSession['isLookingForPlayers']),
            boolval($gameSession['isOver']),
            json_decode($gameSession['stack'] ?? '[]'),
            Player::fromId(intval($gameSession['playerOneId']), $database),
            Player::fromId(intval($gameSession['playerTwoId']), $database)
        );
    }

    static public function fromId(int $gameId, Database $database, bool $doDebug = false): GameSession {
        $sql = <<<SQL
            WHERE game.id = :gameId
        SQL;
        $replacements = [
          'gameId' => ['value' => $gameId, 'type' => PDO::PARAM_INT]
        ];
        return self::fromQuery($sql, $replacements, $database, $doDebug);
    }

    public function getId(): int {
        return $this->id;
    }

    public function getIsLookingForPlayers(): int {
        return $this->isLookingForPlayers;
    }

    public function output(int $userId): array {
        $default = array(
            'id' => $this->id,
            'isLookingForPlayers' => $this->isLookingForPlayers,
        );
        if ($this->isLookingForPlayers) {
            return $default;
        }
        return array_merge($default, array(
            'metaData' => $this->getMetaData(),
            'stack' => $this->stack,
            'playerOne' => $this->playerOne->output($userId),
            'playerTwo' => $this->playerTwo->output($userId)
        ));
    }

    private function getMetaData(): array {
        return array(
                'formatId' => $this->format->getId(),
                'formatName' => $this->format->getName(),
                'startingPlayer' => $this->startingPlayer,
                'turnPlayer' => $this->turnPlayer,
                'turnNumber' => $this->turnNumber,
                'isOver' => $this->isOver
        );
    }
}