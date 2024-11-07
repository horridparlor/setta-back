<?php

const DECKLIST_COLUMNS_TO_DECODE = [
    'cardList'
];
const NEW_DECKLIST_NAME_SQL = <<<SQL
    SELECT :comparedValue
    FROM decklist
    WHERE name = :comparedValue
    AND ownerId = :ownerId
SQL;

const NEW_DECKLIST_NAME_REPLACEMENTS = array(
    'ownerId' => ['value' => '$ownerId', 'type' => PDO::PARAM_INT]
);

const UNIQUE_DECKLIST_NAME_SQL = <<<SQL
    SELECT :comparedValue
    FROM decklist
    WHERE name = :comparedValue
    AND ownerId = :ownerId
    AND NOT id = :decklistId
SQL;

const UNIQUE_DECKLIST_NAME_REPLACEMENTS = array(
    'decklistId' => ['value' => '$decklistId', 'type' => PDO::PARAM_INT],
    'ownerId' => ['value' => '$ownerId', 'type' => PDO::PARAM_INT]
);

const DECKLIST_EXISTS_SQL = <<<SQL
    SELECT :comparedValue, "Decklist" entityType
    FROM DUAL
    WHERE NOT EXISTS (
        SELECT id
        FROM decklist
        WHERE id = :comparedValue
    )
SQL;

const SELECT_DECKLIST = <<<SQL
    SELECT
        user.id,
        username,
        firstname,
        lastname,
        penName,
        email,
        phoneNumber,
        isActive,
        roleId,
        CASE
            WHEN role.id IS NOT NULL THEN role.accessRights
            ELSE IFNULL(user.accessRights, "{}")
        END AS accessRights,
        CASE
            WHEN tr.id IS NOT NULL THEN JSON_OBJECT(
                'id', tr.id,
                'userId', tr.userId,
                'cardsInQueue', 0,
                'createdAt', tr.createdAt
            )
            ELSE null
        END AS tokenRequest
    FROM user
    LEFT JOIN userRole role
        ON role.id = user.roleId
    LEFT JOIN tokenRequest tr
        ON tr.userId = user.id
    WHERE user.id > 0
SQL;
