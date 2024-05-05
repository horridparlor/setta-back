<?php

use system\Database;
use brain\Brain;

header('Content-Type: application/json');

include("../system/Database.php");
include("../scripts/Brain.php");

function putCard(Database $database): string
{
    $cardName = $database->getStringParam('cardName');
    $isAce = $database->getBooleanParam('isAce');
    $cardClassId = $database->getIntParam('cardClassId');
    $cardTypeId = $database->getIntParam('cardTypeId');
    $subtypeId = $database->getIntParam('subtypeId');
    $maximumPieceId = $database->getIntParam('maximumPieceId');
    $level = $database->getIntParam('level');
    $atk = $database->getIntParam('atk');
    $def = $database->getIntParam('def');
    $primaryMaterialId  = $database->getIntParam('primaryMaterialId');
    $secondaryMaterialId = $database->getIntParam('secondaryMaterialId');;
    $tertiaryMaterialId = $database->getIntParam('tertiaryMaterialId');
    $costText = $database->getStringParam('costEffect');
    $effectText = $database->getStringParam('effectEffect');
    $flavourText = $database->getStringParam('flavourEffect');
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
            expansionId,
            expansionId
        )
        VALUES (
            :cardName,
            :isAce,
            :cardClassId,
            :cardTypeId,
            :subtypeId,
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

        SELECT LAST_INSERT_ID();
    SQL;
    $replacements = array(
        'cardName' => ['value' => $cardName, 'type' => PDO::PARAM_STR],
        'isAce' => ['value' => $isAce, 'type' => PDO::PARAM_INT],
        'cardClassId' => ['value' => $cardClassId, 'type' => PDO::PARAM_INT],
        'cardTypeId' => ['value' => $cardTypeId, 'type' => PDO::PARAM_INT],
        'subtypeId' => ['value' => $subtypeId, 'type' => PDO::PARAM_INT],
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
    $result = $database->query($sql, $replacements);

    return $database->responseSuccess(array(
        "cardId" => $result[0],
    ));
}

$database = new Database();
$database->handleRequest(null, null, 'putCard');

