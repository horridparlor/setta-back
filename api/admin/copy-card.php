<?php

use system\Database;
use system\AccessBlock;
use system\StandardType;
use system\SqlComparison;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include("../../system/AccessBlock.php");
include("../../system/sql/selectCard.php");
include("../../system/util/images.php");

function copyCard(Database $database): string
{
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized();
    }
    $cardId = $database->getIntParam('cardId');
    $serializedName = $database->getStringParam('serializedName');
    $doErrata = $database->getBooleanParam('doErrata', false);

    $existsSql = <<<SQL
        SELECT :comparedValue
        FROM DUAL
        WHERE NOT EXISTS (
            SELECT card.id
            FROM card
            JOIN expansion
            ON expansion.id = card.expansionId
            WHERE card.id = :comparedValue
            AND card.isDeleted = 0
            AND (expansion.isReleased = 1 OR :doErrata = 0)
        )
    SQL;
    $existsReplacements = array(
        'doErrata' => ['value' => $doErrata, 'type' => PDO::PARAM_BOOL],
    );

    $requiredParams = array(
        array(
          'param' => 'cardId',
          'type' => StandardType::ID,
          'exists' => new SqlComparison($existsSql, $existsReplacements)
        ),
        array(
            'param' => 'serializedName',
            'type' => StandardType::STRING
        ),
        array(
            'param' => 'doErrata',
            'type' => StandardType::BOOLEAN
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }

    $sql = <<<SQL
        UPDATE card
        SET serializedName = :serializedName
        WHERE id = :cardId
        AND serializedName = '';

        UPDATE card
        SET errataOfId = :cardId
        WHERE id = :cardId
        AND errataOfId IS NULL;
    SQL;
    $replacements = array(
        'cardId' => ['value' => $cardId, 'type' => PDO::PARAM_INT],
        'serializedName' => ['value' => $serializedName, 'type' => PDO::PARAM_STR]
    );
    $database->query($sql, $replacements);

    $sql = <<<SQL
        INSERT INTO card (
            ownerId,
            errataOfId,
            cardName,
            serializedName,
            isAce,
            cardClassId,
            cardTypeId,
            subtypeId,
            supertypeId,
            maximumPieceId,
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
            isDeleted,
            modifiedBy 
        )
        SELECT
            IF(:doErrata = 1,
                c.ownerId,
                :userId
            ) AS ownerId,
            IF(:doErrata = 1,
                IF(c.errataOfId = :cardId, :cardId, c.errataOfId),
                NULL
            ) AS errataOfId,
            c.cardName,
            c.serializedName,
            c.isAce,
            c.cardClassId,
            c.cardTypeId,
            c.subtypeId,
            c.supertypeId,
            c.maximumPieceId,
            c.level,
            c.atk,
            c.def,
            c.primaryMaterialId,
            c.secondaryMaterialId,
            c.tertiaryMaterialId,
            c.materialsReminder,
            c.costText,
            c.effectText,
            c.flavourText,
            c.countsAsId,
            c.artScale,
            c.artXOffset,
            c.artYOffset,
            c.nameSize,
            c.materialsSize,
            c.effectsSize,
            e.expansionId,
            0,
            :userId
        FROM (
            SELECT
                ownerId,
                errataOfId,
                cardName,
                serializedName,
                isAce,
                cardClassId,
                cardTypeId,
                subtypeId,
                supertypeId,
                maximumPieceId,
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
                effectsSize
            FROM card
            WHERE id = :cardId
        ) AS c,
        (
            SELECT id AS expansionId
            FROM expansion
            WHERE ownerId = 0
            LIMIT 1
        ) AS e;
    SQL;
    $replacements = array(
        'cardId' => ['value' => $cardId, 'type' => PDO::PARAM_INT],
        'userId' => ['value' => $user->getId(), 'type' => PDO::PARAM_INT],
        'doErrata' => ['value' => intval($doErrata), 'type' => PDO::PARAM_BOOL],
    );
    $database->query($sql, $replacements);
    $copyId = $database->getInsertId();
    copyArtwork($cardId, $copyId, $database, $doErrata);

    $sql = SELECT_CARD . <<<SQL
        WHERE card.id = :copyId
    SQL;

    $replacements = array(
        'copyId' => ['value' => $copyId, 'type' => PDO::PARAM_INT],
    );
    $newCard = $database->query($sql, $replacements)[0];

    return $database->responseSuccess($newCard);
}

$database = new Database();
$database->handleRequest(null, 'copyCard');

