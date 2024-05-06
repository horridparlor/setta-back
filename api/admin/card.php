<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");

function postCard(Database $database): string
{
    $cardName = $database->getStringParam('cardName');
    $isAce = $database->getBooleanParam('isAce');
    $cardClassId = $database->getIntParam('cardClassId');
    $cardTypeId = $database->getIntParam('cardTypeId');
    $subtypeId = $database->getIntParam('subtypeId');
    $supertypeId = $database->getIntParam('supertypeId');
    $maximumPieceId = $database->getIntParam('maximumPieceId');
    $level = $database->getIntParam('level');
    $atk = $database->getIntParam('atk');
    $def = $database->getIntParam('def');
    $primaryMaterialId  = $database->getIntParam('primaryMaterialId');
    $secondaryMaterialId = $database->getIntParam('secondaryMaterialId');;
    $tertiaryMaterialId = $database->getIntParam('tertiaryMaterialId');
    $costText = $database->getStringParam('costText');
    $effectText = $database->getStringParam('effectText');
    $flavourText = $database->getStringParam('flavourText');
    $countsAsId = $database->getIntParam('countsAsId');
    $artScale = $database->getFloatParam('artScale');
    $artXOffset = $database->getFloatParam('artXOffset');
    $artYOffset = $database->getFloatParam('artYOffset');
    $nameSize = $database->getIntParam('nameSize');
    $materialsSize = $database->getIntParam('materialsSize');
    $effectsSize = $database->getIntParam('effectsSize');
    $expansionId = $database->getIntParam('expansionId');
    $sql = <<<SQL
        INSERT INTO card (
            cardName,
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
            expansionId
        )
        VALUES (
            :cardName,
            :isAce,
            :cardClassId,
            :cardTypeId,
            :subtypeId,
            :supertypeId,
            :maximumPieceId,
            :level,
            :atk,
            :def,
            :primaryMaterialId,
            :secondaryMaterialId,
            :tertiaryMaterialId,
            :costText,
            :effectText,
            :flavourText,
            :countsAsId,
            :artScale,
            :artXOffset,
            :artYOffset,
            :nameSize,
            :materialsSize,
            :effectsSize,
            :expansionId
        );
    SQL;
    $replacements = array(
        'cardName' => ['value' => $cardName, 'type' => PDO::PARAM_STR],
        'isAce' => ['value' => $isAce, 'type' => PDO::PARAM_INT],
        'cardClassId' => ['value' => $cardClassId, 'type' => PDO::PARAM_INT],
        'cardTypeId' => ['value' => $cardTypeId, 'type' => PDO::PARAM_INT],
        'subtypeId' => ['value' => $subtypeId, 'type' => PDO::PARAM_INT],
        'supertypeId' => ['value' => $supertypeId, 'type' => PDO::PARAM_INT],
        'maximumPieceId' => ['value' => $maximumPieceId, 'type' => PDO::PARAM_INT],
        'level' => ['value' => $level, 'type' => PDO::PARAM_INT],
        'atk' => ['value' => $atk, 'type' => PDO::PARAM_INT],
        'def' => ['value' => $def, 'type' => PDO::PARAM_INT],
        'primaryMaterialId' => ['value' => $primaryMaterialId, 'type' => PDO::PARAM_INT],
        'secondaryMaterialId' => ['value' => $secondaryMaterialId, 'type' => PDO::PARAM_INT],
        'tertiaryMaterialId' => ['value' => $tertiaryMaterialId, 'type' => PDO::PARAM_INT],
        'costText' => ['value' => $costText, 'type' => PDO::PARAM_STR],
        'effectText' => ['value' => $effectText, 'type' => PDO::PARAM_STR],
        'flavourText' => ['value' => $flavourText, 'type' => PDO::PARAM_STR],
        'countsAsId' => ['value' => $countsAsId, 'type' => PDO::PARAM_INT],
        'artScale' => ['value' => $artScale, 'type' => PDO::PARAM_INT],
        'artXOffset' => ['value' => $artXOffset, 'type' => PDO::PARAM_INT],
        'artYOffset' => ['value' => $artYOffset, 'type' => PDO::PARAM_INT],
        'nameSize' => ['value' => $nameSize, 'type' => PDO::PARAM_INT],
        'materialsSize' => ['value' => $materialsSize, 'type' => PDO::PARAM_INT],
        'effectsSize' => ['value' => $effectsSize, 'type' => PDO::PARAM_INT],
        'expansionId' => ['value' => $expansionId, 'type' => PDO::PARAM_INT]
    );
    $database->query($sql, $replacements);
    $result = $database->query('SELECT LAST_INSERT_ID() cardId;');

    return $database->responseSuccess(array(
        'cardId' => $result[0]['cardId'],
    ));
}

function putCard(Database $database): string
{
    $cardId = $database->getIntParam('cardId');
    $cardName = $database->getStringParam('cardName');
    $isAce = $database->getBooleanParam('isAce');
    $cardClassId = $database->getIntParam('cardClassId');
    $cardTypeId = $database->getIntParam('cardTypeId');
    $subtypeId = $database->getIntParam('subtypeId');
    $supertypeId = $database->getIntParam('supertypeId');
    $maximumPieceId = $database->getIntParam('maximumPieceId');
    $level = $database->getIntParam('level');
    $atk = $database->getIntParam('atk');
    $def = $database->getIntParam('def');
    $primaryMaterialId  = $database->getIntParam('primaryMaterialId');
    $secondaryMaterialId = $database->getIntParam('secondaryMaterialId');;
    $tertiaryMaterialId = $database->getIntParam('tertiaryMaterialId');
    $costText = $database->getStringParam('costText');
    $effectText = $database->getStringParam('effectText');
    $flavourText = $database->getStringParam('flavourText');
    $countsAsId = $database->getIntParam('countsAsId');
    $artScale = $database->getFloatParam('artScale');
    $artXOffset = $database->getFloatParam('artXOffset');
    $artYOffset = $database->getFloatParam('artYOffset');
    $nameSize = $database->getIntParam('nameSize');
    $materialsSize = $database->getIntParam('materialsSize');
    $effectsSize = $database->getIntParam('effectsSize');
    $expansionId = $database->getIntParam('expansionId');
    $sql = <<<SQL
        UPDATE card SET
            cardName = :cardName,
            isAce = :isAce,
            cardClassId = :cardClassId,
            cardTypeId = :cardTypeId,
            subtypeId = :subtypeId,
            supertypeId = :supertypeId,
            maximumPieceId = :maximumPieceId,
            level = :level,
            atk = :atk,
            def = :def,
            primaryMaterialId = :primaryMaterialId,
            secondaryMaterialId = :secondaryMaterialId,
            tertiaryMaterialId = :tertiaryMaterialId,
            costText = :costText,
            effectText = :effectText,
            flavourText = :flavourText,
            countsAsId = :countsAsId,
            artScale = :artScale,
            artXOffset = :artXOffset,
            artYOffset = :artYOffset,
            nameSize = :nameSize,
            materialsSize = :materialsSize,
            effectsSize = :effectsSize,
            expansionId = :expansionId
        WHERE id = :cardId;
    SQL;
    $replacements = array(
        'cardId' => ['value' => $cardId, 'type' => PDO::PARAM_INT],
        'cardName' => ['value' => $cardName, 'type' => PDO::PARAM_STR],
        'isAce' => ['value' => $isAce, 'type' => PDO::PARAM_INT],
        'cardClassId' => ['value' => $cardClassId, 'type' => PDO::PARAM_INT],
        'cardTypeId' => ['value' => $cardTypeId, 'type' => PDO::PARAM_INT],
        'subtypeId' => ['value' => $subtypeId, 'type' => PDO::PARAM_INT],
        'supertypeId' => ['value' => $supertypeId, 'type' => PDO::PARAM_INT],
        'maximumPieceId' => ['value' => $maximumPieceId, 'type' => PDO::PARAM_INT],
        'level' => ['value' => $level, 'type' => PDO::PARAM_INT],
        'atk' => ['value' => $atk, 'type' => PDO::PARAM_INT],
        'def' => ['value' => $def, 'type' => PDO::PARAM_INT],
        'primaryMaterialId' => ['value' => $primaryMaterialId, 'type' => PDO::PARAM_INT],
        'secondaryMaterialId' => ['value' => $secondaryMaterialId, 'type' => PDO::PARAM_INT],
        'tertiaryMaterialId' => ['value' => $tertiaryMaterialId, 'type' => PDO::PARAM_INT],
        'costText' => ['value' => $costText, 'type' => PDO::PARAM_STR],
        'effectText' => ['value' => $effectText, 'type' => PDO::PARAM_STR],
        'flavourText' => ['value' => $flavourText, 'type' => PDO::PARAM_STR],
        'countsAsId' => ['value' => $countsAsId, 'type' => PDO::PARAM_INT],
        'artScale' => ['value' => $artScale, 'type' => PDO::PARAM_INT],
        'artXOffset' => ['value' => $artXOffset, 'type' => PDO::PARAM_INT],
        'artYOffset' => ['value' => $artYOffset, 'type' => PDO::PARAM_INT],
        'nameSize' => ['value' => $nameSize, 'type' => PDO::PARAM_INT],
        'materialsSize' => ['value' => $materialsSize, 'type' => PDO::PARAM_INT],
        'effectsSize' => ['value' => $effectsSize, 'type' => PDO::PARAM_INT],
        'expansionId' => ['value' => $expansionId, 'type' => PDO::PARAM_INT]
    );
    $database->query($sql, $replacements);
    return $database->responseSuccess(array(
        'cardId' => $cardId,
    ));
}

$database = new Database();
$database->handleRequest(null, 'postCard', 'putCard');

