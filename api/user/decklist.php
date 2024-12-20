<?php

use system\Database;
use system\AccessBlock;
use system\StandardType;
use system\SqlComparison;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include("../../system/AccessBlock.php");
include("../../system/sql/selectFormat.php");
include("../../system/sql/selectCard.php");
include("../../system/sql/selectDeckBlock.php");
include("../../system/sql/selectDecklist.php");


function getDecklist(Database $database): string
{
    return "222";
}

function postDecklist(Database $database): string
{
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized($user?->getError());
    }
    $decklistNameReplacements = array(
        'ownerId' => ['value' => $user->getId(), 'type' => PDO::PARAM_INT]
    );

    $requiredParams = array(
        array(
            'param' => 'formatId',
            'type' => StandardType::ID,
            'exists' => new SqlComparison(FORMAT_EXISTS_SQL),
            'required' => false
        ),
        array(
            'param' => 'name',
            'type' => StandardType::STRING,
            'unique' => new SqlComparison(NEW_DECKLIST_NAME_SQL, $decklistNameReplacements),
        ),
        array(
            'param' =>  'doPublish',
            'type' => StandardType::BOOLEAN,
            'required' => false
        ),
        array(
            'param' => 'cards',
            'iterative' => array(
                array(
                    'param' => 'cardId',
                    'type' => StandardType::ID,
                    'exists' => new SqlComparison(CARD_EXISTS_IN_GAME_SQL)
                ),
                array(
                    'param' => 'copies',
                    'type' => StandardType::NUMBER,
                    'min' => 0,
                    'max' => 3
                ),
                array(
                    'param' => 'deckBlock',
                    'type' => StandardType::STRING,
                    'exists' => new SqlComparison(DECK_BLOCK_NAME_EXISTS_SQL)
                )
            )
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $formatId = $database->getIntParam("formatId", 1);
    $name = $database->getStringParam("name");
    $doPublish = $database->getBooleanParam("doPublish", false);
    $cards = $database->getObjectParam("cards");
    $isValid = validateDecklist($cards);
    $sql = <<<SQL
        INSERT INTO decklist (
            ownerId,
            formatId,
            name,
            isValid,
            isPublished
        ) VALUES (
            :ownerId,
            :formatId,
            :name,
            :isValid,
            :isPublished
        )
    SQL;
    $replacements = array(
        'ownerId' => ['value' => $user->getId(), 'type' => PDO::PARAM_INT],
        'formatId' => ['value' => $formatId, 'type' => PDO::PARAM_INT],
        'name' => ['value' => $name, 'type' => PDO::PARAM_STR],
        'isValid' => ['value' => $isValid, 'type' => PDO::PARAM_BOOL,],
        'isPublished' => ['value' => $doPublish && $isValid, 'type' => PDO::PARAM_BOOL]
    );
    $database->query($sql, $replacements);

    return $database->responseSuccess(array(
        'decklistId' => $database->getInsertId(),
        'isValid' => $isValid
    ));
}

function validateDecklist(array $cards): bool {
    $deckMasterCount = 0;
    $mainDeckCount = 0;
    $extraDeckCount = 0;
    $sideDeckCount = 0;
    foreach ($cards as $card) {
        $copies = $card->copies;
        switch ($card->deckBlock) {
            case DeckBlock::DECK_MASTER:
                $deckMasterCount += 1;
                break;
            case DeckBlock::MONSTER:
            case DeckBlock::SPELL:
            case DeckBlock::TRAP:
                $mainDeckCount += $copies;
                break;
            case DeckBlock::EXTRA:
                $extraDeckCount += $copies;
                break;
            case DeckBlock::SIDE:
                $sideDeckCount += $copies;
                break;
        }
    }
    return $deckMasterCount == DECK_MASTER_COUNT && $mainDeckCount == MAIN_DECK_COUNT &&
        $extraDeckCount < EXTRA_DECK_MAX_COUNT && $sideDeckCount < SIDE_DECK_MAX_COUNT;
}

function putDecklist(Database $database): string
{
    return "222";
}

function deleteDecklist(Database $database): string
{
    $deckId = $database->getIntParam('deckId');

    return $database->responseSuccess(array(
        'deckId' => $deckId,
    ));
}

$database = new Database();
$database->handleRequest('getDecklist', 'postDecklist', 'putDecklist', 'deleteDecklist');
