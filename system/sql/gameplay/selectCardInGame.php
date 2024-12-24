<?php


const SELECT_CARD_IN_GAME = <<<SQL
    SELECT
        card.id,
        cardData.serializedName,
        card.cardId,
        card.ownerId,
        card.controllerId,
        zone.name zone,
        card.index,
        card.isSet,
        card.isHidden,
        card.inDefense,
        card.inMaximumMode,
        card.attachedToId,
        card.levelGain,
        card.atkGain,
        card.defGain,
        card.canBePlayed,
        card.canBeMaximumSummoned,
        card.canBeActivated,
        card.canChangePosition,
        card.summonedThisTurn,
        summonedFromZone.name summonedFrom,
        card.keywordsJson,
        card.effectsJson,
        card.rulerEffectsJson
    FROM cardInGame card
    JOIN card cardData
        ON cardData.id = card.cardId
    JOIN zone
        ON zone.id = card.zoneId
    LEFT JOIN zone summonedFromZone
        ON summonedFromZone.id = card.summonedFromId
    WHERE card.gameId = :gameId
SQL;

