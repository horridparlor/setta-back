<?php

const SELECT_CARD = <<<SQL
    SELECT
        card.id cardId,
        card.ownerId,
        
        cardOwner.firstname ownerFirstname,
        cardOwner.lastname ownerLastname,
        cardName,
        isAce,
        cardClass.name cardClass,
        cardType.name cardType,
        cardSubtype.name subtype,
        cardSupertype.name supertype,
        maximumPiece.name maximumPiece,
        level,
        atk,
        def,
        primaryMaterialId,
        secondaryMaterialId,
        tertiaryMaterialId,
        materialsReminder,
        costText,
        effectText,
        flavourText,
        countsAsId,
        artScale,
        artXOffset,
        artYOffset,
        nameSize,
        materialsSize,
        effectsSize,
        expansionId,
        card.created_at,
        card.updated_at
    FROM card
    JOIN user cardOwner
        ON cardOwner.id = card.ownerId
    JOIN expansion
        ON expansion.id = card.expansionId
    LEFT JOIN user expansionOwner
        ON expansionOwner.id = expansion.ownerId
    JOIN cardClass
        ON cardClass.id = card.cardClassId
    JOIN cardType
        ON cardType.id = card.cardTypeId
    JOIN cardSubtype
        ON cardSubtype.id = card.subtypeId
    JOIN cardSupertype
        ON cardSupertype.id = card.supertypeId
    JOIN maximumPiece
        ON maximumPiece.id = card.maximumPieceId
SQL;
