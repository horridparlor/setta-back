<?php


const SELECT_GAME_SESSION = <<<SQL
        SELECT game.id, game.isLookingForPlayers
        FROM gameSession game
SQL;