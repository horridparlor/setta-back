<?php

const DECK_MASTER_COUNT = 1;
const MAIN_DECK_COUNT = 60;
const EXTRA_DECK_MAX_COUNT = 15;
const SIDE_DECK_MAX_COUNT = 15;
enum DeckBlock: string {
    case DECK_MASTER = 'deckMaster';
    case MONSTER = 'monster';
    case SPELL = 'spell';
    case TRAP = 'trap';
    case EXTRA = 'extra';
    case SIDE = 'side';

    public static function fromString(string $value): ?DeckBlock {
        return match($value) {
            self::DECK_MASTER->value => self::DECK_MASTER,
            self::MONSTER->value => self::MONSTER,
            self::SPELL->value => self::SPELL,
            self::TRAP->value => self::TRAP,
            self::EXTRA->value => self::EXTRA,
            self::SIDE->value => self::SIDE,
            default => null,
        };
    }
}



const DECK_BLOCK_NAME_EXISTS_SQL = <<<SQL
    SELECT :comparedValue, "DeckBlock" entityType
    FROM DUAL
    WHERE NOT EXISTS (
        SELECT id
        FROM deckBlock
        WHERE name = :comparedValue
    )
SQL;
