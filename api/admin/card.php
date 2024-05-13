<?php

use system\Database;
use system\User;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include("../../system/util/images.php");

function postCard(Database $database): string
{
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized();
    }

    $cardName = $database->getStringParam('cardName');
    $isAce = $database->getBooleanParam('isAce');
    $cardClass = $database->getStringParam('cardClass');
    $cardType = $database->getStringParam('cardType');
    $subtype = $database->getStringParam('subtype');
    $supertype = $database->getStringParam('supertype');
    $maximumPiece = $database->getStringParam('maximumPiece');
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

    $error = hasAccessToExpansion($expansionId, $user, $database);
    if ($error) {
        return $error;
    }

    $sql = <<<SQL
        INSERT INTO card (
            ownerId,
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
            expansionId,
            isDeleted,
            modifiedBy
        )
        VALUES (
            :ownerId,
            :cardName,
            :isAce,
            (SELECT id FROM cardClass WHERE name = :cardClass),
            (SELECT id FROM cardType WHERE name = :cardType),
            (SELECT id FROM cardSubtype WHERE name = :subtype),
            (SELECT id FROM cardSupertype WHERE name = :supertype),
            (SELECT id FROM maximumPiece WHERE name = :maximumPiece),
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
            :expansionId,
            0,
            :ownerId
        );
    SQL;
    $replacements = array(
        'ownerId' => ['value' => $user->getId(), 'type' => PDO::PARAM_INT],
        'cardName' => ['value' => $cardName, 'type' => PDO::PARAM_STR],
        'isAce' => ['value' => $isAce, 'type' => PDO::PARAM_INT],
        'cardClass' => ['value' => $cardClass, 'type' => PDO::PARAM_STR],
        'cardType' => ['value' => $cardType, 'type' => PDO::PARAM_STR],
        'subtype' => ['value' => $subtype, 'type' => PDO::PARAM_STR],
        'supertype' => ['value' => $supertype, 'type' => PDO::PARAM_STR],
        'maximumPiece' => ['value' => $maximumPiece, 'type' => PDO::PARAM_STR],
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

function hasAccessToCard(int $cardId, User $user, Database $database): string|null {
    $sql = <<<SQL
        SELECT card.ownerId cardOwnerId, expansion.ownerId expansionOwnerId, expansion.isReleased isReleased
        FROM card
        JOIN expansion
            ON card.expansionId = expansion.id
        WHERE card.id = :cardId
    SQL;
    $replacements = array(
        'cardId' => ['value' => $cardId, 'type' => PDO::PARAM_INT]
    );
    $result = $database->query($sql, $replacements);
    if (!$user->isAdmin() && (!sizeof($result) || $result[0]['cardOwnerId'] != $user->getId())) {
        return $database->responseUnauthorized(array(
            'error' => 'You do not own this card.'
        ));
    }
    $expansionOwnerId = $result[0]['expansionOwnerId'];
    if (!$user->isAdmin() && $expansionOwnerId != 0 && $expansionOwnerId != $user->getId()) {
        return $database->responseUnauthorized(array(
            'error' => 'The card is moved to an expansion not owned by you.'
        ));
    } else if (intval($result[0]['isReleased']) == 1) {
       return $database->responseForbidden(array(
           'error' => 'Released cards cannot be altered.'
       ));
    }
    return null;
}

function hasAccessToExpansion(int $expansionId, User $user, Database $database): string|null {
    $sql = <<<SQL
        SELECT ownerId, isReleased
        FROM expansion
        WHERE id = :expansionId
    SQL;
    $replacements = array(
        'expansionId' => ['value' => $expansionId, 'type' => PDO::PARAM_INT],
    );
    $expansion = $database->query($sql, $replacements);
    if (!sizeof($expansion) || ($expansion[0]['ownerId'] != 0 && $expansion[0]['ownerId'] != $user->getId())) {
        return $database->responseUnauthorized(array(
            'error' => 'You do not own this expansion.'
        ));
    } elseif ($expansion[0]['isReleased'] == 1) {
        return $database->responseForbidden(array(
            'error' => 'Released expansion cannot be altered.'
        ));
    }
    return null;
}

function putCard(Database $database): string
{
    $user = $database->getUser();
    $cardId = $database->getIntParam('cardId');
    if (!$user) {
        return $database->responseUnauthorized();
    }
    $error = hasAccessToCard($cardId, $user, $database);
    if ($error) {
        return $error;
    }

    $sql = <<<SQL
        SELECT artScale, artXOffset, artYOffset
        FROM card
        WHERE id = :cardId
    SQL;
    $replacements = array(
        'cardId' => ['value' => $cardId, 'type' => PDO::PARAM_INT],
    );
    $oldCard = $database->query($sql, $replacements);
    $oldArtScale = floatval($oldCard[0]['artScale']);
    $oldArtXOffset = floatval($oldCard[0]['artXOffset']);
    $oldArtYOffset = floatval($oldCard[0]['artYOffset']);

    $cardName = $database->getStringParam('cardName');
    $oldSerializedName = $database->getStringParam('oldSerializedName');
    $serializedName = $database->getStringParam('serializedName');
    $isAce = $database->getBooleanParam('isAce');
    $cardClass = $database->getStringParam('cardClass');
    $cardType = $database->getStringParam('cardType');
    $subtype = $database->getStringParam('subtype');
    $supertype = $database->getStringParam('supertype');
    $maximumPiece = $database->getStringParam('maximumPiece');
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

    $error = hasAccessToExpansion($expansionId, $user, $database);
    if ($error) {
        return $error;
    }

    $sql = <<<SQL
        UPDATE card SET
            cardName = :cardName,
            isAce = :isAce,
            cardClassId = (SELECT id FROM cardClass WHERE name = :cardClass),
            cardTypeId = (SELECT id FROM cardType WHERE name = :cardType),
            subtypeId = (SELECT id FROM cardSubtype WHERE name = :subtype),
            supertypeId = (SELECT id FROM cardSupertype WHERE name = :supertype),
            maximumPieceId = (SELECT id FROM maximumPiece WHERE name = :maximumPiece),
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
            expansionId = :expansionId,
            modifiedBy = :userId
        WHERE id = :cardId;
    SQL;
    $replacements = array(
        'cardId' => ['value' => $cardId, 'type' => PDO::PARAM_INT],
        'cardName' => ['value' => $cardName, 'type' => PDO::PARAM_STR],
        'isAce' => ['value' => $isAce, 'type' => PDO::PARAM_INT],
        'cardClass' => ['value' => $cardClass, 'type' => PDO::PARAM_STR],
        'cardType' => ['value' => $cardType, 'type' => PDO::PARAM_STR],
        'subtype' => ['value' => $subtype, 'type' => PDO::PARAM_STR],
        'supertype' => ['value' => $supertype, 'type' => PDO::PARAM_STR],
        'maximumPiece' => ['value' => $maximumPiece, 'type' => PDO::PARAM_STR],
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
        'expansionId' => ['value' => $expansionId, 'type' => PDO::PARAM_INT],
        'userId' => ['value' => $user->getId(), 'type' => PDO::PARAM_INT],
    );
    $database->query($sql, $replacements);

    $sql = <<<SQL
        SELECT ownerId
        FROM card
        WHERE id = :ownerId;
    SQL;
    $replacements = array(
        'ownerId' => ['value' => $cardId, 'type' => PDO::PARAM_INT],
    );
    $card = $database->query($sql, $replacements);

    $ownerId = intval($card[0]['ownerId']);

    if ($serializedName != $oldSerializedName) {
        $errorMessage = renameCardArt($oldSerializedName, $serializedName, $ownerId, $cardId);
    }
    if ($artScale != $oldArtScale || $artXOffset != $oldArtXOffset || $artYOffset != $oldArtYOffset) {
        $error = updateThumbnail($ownerId, $cardId, $serializedName, $artScale, $artXOffset, $artYOffset, $database);
        if (strlen($error)) {
            return $error;
        }
    }

    return $database->responseSuccess(array(
        'cardId' => $cardId,
    ));
}

function deleteCard(Database $database): string
{
    $user = $database->getUser();
    $cardId = $database->getIntParam('cardId');
    if (!$user) {
        return $database->responseUnauthorized();
    }
    $error = hasAccessToCard($cardId, $user, $database);
    if ($error) {
        return $error;
    }

    $sql = <<<SQL
        UPDATE card
        SET
            isDeleted = 1,
            modifiedBy = :userId
        WHERE id = :cardId;
    SQL;
    $replacements = array(
        'cardId' => ['value' => $cardId, 'type' => PDO::PARAM_INT],
        'userId' => ['value' => $user->getId(), 'type' => PDO::PARAM_INT],
    );
    $database->query($sql, $replacements);
    return $database->responseSuccess(array(
        'cardId' => $cardId,
    ));
}

$database = new Database();
$database->handleRequest(null, 'postCard', 'putCard', 'deleteCard');

