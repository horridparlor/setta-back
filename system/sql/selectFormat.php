<?php

const SELECT_FORMAT_SQL = <<<SQL
    SELECT
        id,
        name,
        mainDeckSize,
        hasExtraDeck,
        maxCopies,
        hasSideDeck
    FROM format
    WHERE isActive = 1
SQL;