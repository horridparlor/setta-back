<?php

const SELECT_TOKEN_REQUEST = <<<SQL
    SELECT
        tr.id,
        user.id userId,
        0 cardsInQueue,
        tr.createdAt
    FROM tokenRequest tr
    JOIN user
        ON user.id = tr.userId
SQL;