<?php

const SELECT_CARD = <<<SQL
    SELECT
        card.id cardId,
        card.ownerId,
        card.errataOfId errataOfId,
        cardOwner.firstname ownerFirstname,
        cardOwner.lastname ownerLastname,
        card.cardName,
        card.isAce,
        cardClass.name cardClass,
        cardType.name cardType,
        cardSubtype.name subtype,
        cardSupertype.name supertype,
        maximumPiece.name maximumPiece,
        COALESCE(secondaryClass.name, "None") secondaryClass,
        card.level,
        card.atk,
        card.def,
        card.primaryMaterialId,
        card.secondaryMaterialId,
        card.tertiaryMaterialId,
        card.materialsReminder,
        card.costText,
        card.effectText,
        card.flavourText,
        IF(card.specialCountsAsId IS NULL, card.countsAsId, -card.specialCountsAsId) countsAsId,
        card.artScale,
        card.artXOffset,
        card.artYOffset,
        card.nameSize,
        card.materialsSize,
        card.effectsSize,
        card.expansionId,
        IFNULL(original.expansionId, card.expansionId) originalExpansionId,
        IFNULL(card.effectsJson, '{"cost": {"amount": null, "costType": "None", "payment": null, "postCount": null, "preState": null, "subtype": null, "supertype": null, "target": null}, "effect": {"amount": null, "benefit": null, "chainedEffect": null, "direction": null, "effectType": "None", "hindrance": null, "maxAmount": null, "subtype": null, "supertype": null, "target": null}}') effectsJson,
        card.createdAt,
        card.updatedAt,
        CASE
            WHEN expansionOwnerRole.id IS NOT NULL THEN expansionOwnerRole.accessRights
            ELSE IFNULL(expansionOwner.accessRights, "{}")
        END AS expansionOwnerAccessRights
    FROM card
    JOIN user cardOwner
        ON cardOwner.id = card.ownerId
    JOIN expansion
        ON expansion.id = card.expansionId
    LEFT JOIN user expansionOwner
        ON expansionOwner.id = expansion.ownerId
    LEFT JOIN userRole expansionOwnerRole
        ON expansionOwnerRole.id = expansionOwner.roleId
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
    LEFT JOIN cardClass secondaryClass
        ON secondaryClass.id = card.secondaryClassId
    LEFT JOIN card original
        ON original.id = card.errataOfId
    JOIN expansion originalExpansion
        ON originalExpansion.id = IFNULL(original.expansionId, card.expansionId) 
SQL;

const CARD_EXISTS_IN_GAME_SQL = <<<SQL
    SELECT :comparedValue, "Card" entityType
    FROM DUAL
    WHERE NOT EXISTS (
        SELECT card.id
        FROM card
        JOIN expansion
            ON expansion.id = card.expansionId
        WHERE (
            card.id = :comparedValue
            OR card.errataOfId = :comparedValue
        )
        AND card.isDeleted = 0
        AND expansion.isReleasedForGame = 1
    )
SQL;
