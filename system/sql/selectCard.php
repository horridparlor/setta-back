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
    LEFT JOIN card original
        ON original.id = card.errataOfId
SQL;
