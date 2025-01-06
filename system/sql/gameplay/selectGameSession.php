<?php


const SELECT_GAME_SESSION = <<<SQL
        SELECT
            game.id,
            game.formatId,
            game.startingPlayer,
            game.turnPlayer,
            game.turnNumber,
            game.isLookingForPlayers,
            game.isOver,
            (
                SELECT JSON_ARRAYAGG(
                    JSON_OBJECT(
                        'id', gameAction.id,
                        'actionType', actionType.name,
                        'userId', gameAction.userId,
                        'index', gameAction.index,
                        'actionData', gameAction.actionData
                    )
                )
                FROM gameAction
                JOIN actionType
                    on actionType.id = gameAction.actionTypeId
                WHERE gameAction.gameId = game.id
                AND gameAction.isResolved = 0 
            ) stack,
            playerOne.id playerOneId,
            playerTwo.id playerTwoId
        FROM gameSession game
        LEFT JOIN playerInGame playerOne
            ON playerOne.gameId = game.id AND playerOne.index = 1
        LEFT JOIN playerInGame playerTwo
            ON playerTwo.gameId = game.id AND playerTwo.index = 2
SQL;

const RUNNING_GAME_SESSION_WITH_PLAYER_EXISTS = <<<SQL
    SELECT :comparedValue, "Game" entityType
    FROM DUAL
    WHERE NOT EXISTS (
        SELECT game.id
        FROM gameSession game
        JOIN playerInGame player
            ON player.gameId = game.id
        WHERE game.id = :comparedValue
        AND player.userId = :userId
        AND game.isOver = 0
    )
SQL;
