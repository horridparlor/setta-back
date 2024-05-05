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
    $cardClass = $database->getIntParam('cardClassId');
    $cardType = $database->getIntParam('cardTypeId');
    $subtype = $database->getIntParam('subtypeId');
    $maximumPiece = $database->getIntParam('maximumPieceId');
    $level = $database->getIntParam('level');
    $atk = $database->getIntParam('atk');
    $def = $database->getIntParam('def');
    $primaryMaterial  = $database->getIntParam('primaryMaterialId');
    $secondaryMaterial = $database->getIntParam('secondaryMaterialId');;
    $tertiaryMaterial = $database->getIntParam('tertiaryMaterialId');
    $costText = $database->getStringParam('costEffect');
    $effectText = $database->getStringParam('effectEffect');
    $flavourText = $database->getStringParam('flavourEffect');
    $countsAs = $database->getIntParam('countsAsId');
    $artScale = $database->getFloatParam('artScale');
    $artXOffset = $database->getFloatParam('artXOffset');
    $artYOffset = $database->getFloatParam('artYOffset');
    $nameSize = $database->getIntParam('nameSize');
    $materialsSize = $database->getIntParam('materialsSize');
    $effectsSize = $database->getIntParam('effectsSize');
    $expansionId = $database->getIntParam('expansionId');
    return $database->responseSuccess(array(
        "answer" => "1",
    ));
}

$database = new Database();
$database->handleRequest(null, null, 'putCard');

