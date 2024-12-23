<?php

const DECKLIST_COLUMNS_TO_DECODE = [
    'cards'
];
const NEW_DECKLIST_NAME_SQL = <<<SQL
    SELECT :comparedValue
    FROM decklist
    WHERE name = :comparedValue
    AND ownerId = :ownerId
    AND isDeleted = 0
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
    AND isDeleted = 0
SQL;

const UNIQUE_DECKLIST_NAME_REPLACEMENTS = array(
    'decklistId' => ['value' => '$decklistId', 'type' => PDO::PARAM_INT],
    'ownerId' => ['value' => '$ownerId', 'type' => PDO::PARAM_INT]
);


const PUBLISHED_DECKLIST_EXISTS_SQL = <<<SQL
    SELECT :comparedValue, "Decklist" entityType
    FROM DUAL
    WHERE NOT EXISTS (
        SELECT id
        FROM decklist
        WHERE id = :comparedValue
        AND decklist.isPublished = 1
    )
SQL;


const OWNED_DECKLIST_EXISTS_SQL = <<<SQL
    SELECT :comparedValue, "Decklist" entityType
    FROM DUAL
    WHERE NOT EXISTS (
        SELECT id
        FROM decklist
        WHERE id = :comparedValue
        AND ownerId = :ownerId
    )
SQL;

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
        decklist.id decklistId,
        decklist.name,
        decklist.ownerId,
        owner.firstname ownerFirstname,
        owner.lastname ownerLastname,
        decklist.formatId,
        format.name formatName,
        decklist.isValid,
        decklist.isPublished,
        decklist.createdAt,
        decklist.updatedAt,
        decklist.isDeleted,
        (SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'cardId', cardInDecklist.cardId,
                'name', card.serializedName,
                'copies', cardInDecklist.copies,
                'deckBlock', deckBlock.name
            )
        ) cards
        FROM cardInDecklist
        JOIN deckBlock
            on deckBlock.id = cardInDecklist.deckBlockId
        JOIN card
            on card.id = cardInDecklist.cardId
        WHERE cardInDecklist.deckId = decklist.id
    ) AS cards
    FROM decklist
    JOIN user owner
        ON owner.id = decklist.ownerId
    JOIN format
        ON format.id = decklist.formatId
SQL;