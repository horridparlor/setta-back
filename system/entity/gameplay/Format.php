<?php

namespace System\Entity\Gameplay;

use PDO;
use system\Database;

include ("../../../system/sql/selectFormat.php");

class Format {
    private int $id;
    private string $name;
    private bool $isActive;
    private int $mainDeckSize;
    private int $maxCopies;
    private bool $hasExtraDeck;
    private bool $hasSideDeck;

    public function __construct(
        int $id,
        string $name,
        bool $isActive,
        int $mainDeckSize,
        int $maxCopies,
        bool $hasExtraDeck,
        bool $hasSideDeck
    ) {
        $this->id = $id;
        $this->name = $name;
        $this->isActive = $isActive;
        $this->mainDeckSize = $mainDeckSize;
        $this->maxCopies = $maxCopies;
        $this->hasExtraDeck = $hasExtraDeck;
        $this->hasSideDeck = $hasSideDeck;
    }

    static public function fromQuery(string $sql, array $replacements, Database $database, bool $doDebug = false): Format|null {
        $format = $database->query(SELECT_FORMAT_SQL .  $sql, $replacements, $doDebug);
        if (empty($format)) {
            return null;
        }
        $format = $format[0];
        return new Format(
            intval($format['id']),
            strval($format['name']),
            boolval($format['isActive']),
            intval($format['mainDeckSize']),
            intval($format['maxCopies']),
            boolval($format['hasExtraDeck']),
            boolval($format['hasSideDeck'])
        );
    }

    static public function fromId(int $formatId, Database $database, bool $doDebug = false): Format {
        $sql = <<<SQL
            AND format.id = :formatId
        SQL;
        $replacements = [
            'formatId' => ['value' => $formatId, 'type' => PDO::PARAM_INT]
        ];
        return self::fromQuery($sql, $replacements, $database, $doDebug);
    }

    public function getId(): int {
        return $this->id;
    }

    public function getName(): string {
        return $this->name;
    }
}
