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
