<?php


const SELECT_PLAYER_IN_GAME_SQL = <<<SQL
    SELECT
        player.userId,
        player.gameId,
        game.formatId,
        player.decklistJson,
        player.lifePoints
    FROM playerInGame player
    JOIN gameSession game
        ON game.id = player.gameId
SQL;
