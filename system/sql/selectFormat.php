<?php

const SELECT_FORMAT_SQL = <<<SQL
    SELECT
        id,
        name,
        isActive,
        mainDeckSize,
        hasExtraDeck,
        maxCopies,
        hasSideDeck
    FROM format
    WHERE isActive = 1
SQL;

const FORMAT_EXISTS_SQL = <<<SQL
    SELECT :comparedValue, "Format" entityType
    FROM DUAL
    WHERE NOT EXISTS (
        SELECT id
        FROM format
        WHERE id = :comparedValue
    )
SQL;
