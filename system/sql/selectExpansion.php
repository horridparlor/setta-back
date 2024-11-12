<?php

const SELECT_EXPANSION_SQL = <<<SQL
    SELECT id, ownerId, name, releaseYear, isReleased
    FROM expansion
SQL;