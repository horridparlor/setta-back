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
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized($user?->getError());
    }
    $requiredParams = array(
        array(
            'param' => 'decklistId',
            'type' => StandardType::ID,
            'exists' => new SqlComparison(PUBLISHED_DECKLIST_EXISTS_SQL)
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $decklistId = $database->getIntParam('decklistId');
    $sql = SELECT_DECKLIST . <<<SQL
        WHERE decklist.id = :decklistId
        AND decklist.isPublished = 1
    SQL;
    $replacements = array(
        'decklistId' => ['value' => $decklistId, 'type' => PDO::PARAM_INT]
    );
    $decklists = $database->queryWithDecode($sql, DECKLIST_COLUMNS_TO_DECODE, $replacements);
    return $database->responseSuccess($decklists[0]);
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
            'minSize' => 1,
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
    $formatId = $database->getIntParam('formatId', 1);
    $name = $database->getStringParam('name');
    $doPublish = $database->getBooleanParam('doPublish', false);
    $cards = $database->getObjectParam('cards');
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
    $deckId = $database->getInsertId();
    storeCards($cards, $deckId, $database);

    return $database->responseSuccess(array(
        'decklistId' => $deckId,
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
            case DeckBlock::DECK_MASTER->value:
                $deckMasterCount += $copies;
                break;
            case DeckBlock::MONSTER->value:
            case DeckBlock::SPELL->value:
            case DeckBlock::TRAP->value:
                $mainDeckCount += $copies;
                break;
            case DeckBlock::EXTRA->value:
                $extraDeckCount += $copies;
                break;
            case DeckBlock::SIDE->value:
                $sideDeckCount += $copies;
                break;
        }
    }
    return $deckMasterCount == DECK_MASTER_COUNT && $mainDeckCount == MAIN_DECK_COUNT &&
        $extraDeckCount < EXTRA_DECK_MAX_COUNT && $sideDeckCount < SIDE_DECK_MAX_COUNT;
}

function getDeckBlockId(DeckBlock $block): int {
    return match ($block) {
        DeckBlock::DECK_MASTER => 1,
        DeckBlock::MONSTER => 2,
        DeckBlock::SPELL => 3,
        DeckBlock::TRAP => 4,
        DeckBlock::EXTRA => 5,
        DeckBlock::SIDE => 6,
    };
}

function storeCards(array $cards, int $deckId, Database $database): void {
    $sql = <<<SQL
        INSERT INTO cardInDecklist (
            deckId,
            cardId,
            copies,
            deckBlockId
        ) VALUES
    SQL;
    $isFirst = true;
    foreach ($cards as $card) {
        if ($isFirst) {
            $isFirst = false;
        } else {
            $sql .= ',';
        }
        $sql .= sprintf('(%s, %s, %s, %s)', $deckId, $card->cardId,
            $card->deckBlock == DeckBlock::EXTRA->value ? min(1, $card->copies) : $card->copies,
            getDeckBlockId(DeckBlock::fromString($card->deckBlock)));
    }
    $database->query($sql);
}

function putDecklist(Database $database): string
{
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized($user?->getError());
    }
    $decklistNameReplacements = array(
        'decklistId' => ['value' => '$decklistId', 'type' => PDO::PARAM_INT],
        'ownerId' => ['value' => $user->getId(), 'type' => PDO::PARAM_INT]
    );

    $requiredParams = array(
        array(
            'param' => 'decklistId',
            'type' => StandardType::ID,
            'exists' => new SqlComparison(OWNED_DECKLIST_EXISTS_SQL, $user->getReplacements())
        ),
        array(
            'param' => 'formatId',
            'type' => StandardType::ID,
            'exists' => new SqlComparison(FORMAT_EXISTS_SQL),
            'required' => false
        ),
        array(
            'param' => 'name',
            'type' => StandardType::STRING,
            'unique' => new SqlComparison(UNIQUE_DECKLIST_NAME_SQL, $decklistNameReplacements, $database->getRequestData()),
        ),
        array(
            'param' =>  'doPublish',
            'type' => StandardType::BOOLEAN,
            'required' => false
        ),
        array(
            'param' => 'cards',
            'minSize' => 1,
            'iterative' => array(
                array(
                    'param' => 'cardId',
                    'type' => StandardType::ID,
                    'exists' => new SqlComparison(CARD_EXISTS_IN_GAME_SQL)
                ),
                array(
                    'param' => 'copies',
                    'type' => StandardType::NUMBER,
                    'min' => 1,
                    'max' => 3
                ),
                array(
                    'param' => 'deckBlock',
                    'type' => StandardType::STRING,
                    'exists' => new SqlComparison(DECK_BLOCK_NAME_EXISTS_SQL),
                )
            )
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $decklistId = $database->getIntParam('decklistId');
    $formatId = $database->getIntParam('formatId', 1);
    $name = $database->getStringParam('name');
    $doPublish = $database->getBooleanParam('doPublish', false);
    $cards = $database->getObjectParam('cards');
    $isValid = validateDecklist($cards);
    $sql = <<<SQL
        UPDATE decklist SET
            ownerId = :ownerId,
            formatId = :formatId,
            name = :name,
            isValid = :isValid,
            isPublished = :isPublished,
            updatedAt = NOW()
        WHERE id = :decklistId;
        
        DELETE from cardInDecklist
        WHERE deckId = :decklistId;
    SQL;
    $replacements = array(
        'decklistId' => ['value' => $decklistId, 'type' => PDO::PARAM_INT],
        'ownerId' => ['value' => $user->getId(), 'type' => PDO::PARAM_INT],
        'formatId' => ['value' => $formatId, 'type' => PDO::PARAM_INT],
        'name' => ['value' => $name, 'type' => PDO::PARAM_STR],
        'isValid' => ['value' => $isValid, 'type' => PDO::PARAM_BOOL,],
        'isPublished' => ['value' => $doPublish && $isValid, 'type' => PDO::PARAM_BOOL]
    );
    $database->query($sql, $replacements);
    storeCards($cards, $decklistId, $database);

    return $database->responseSuccess(array(
        'decklistId' => $decklistId,
        'isValid' => $isValid
    ));
}

function deleteDecklist(Database $database): string
{
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized($user?->getError());
    }

    $requiredParams = array(
        array(
            'param' => 'decklistId',
            'type' => StandardType::ID,
            'exists' => new SqlComparison(OWNED_DECKLIST_EXISTS_SQL, $user->getReplacements())
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $decklistId = $database->getIntParam('decklistId');
    $sql = <<<SQL
        DELETE FROM cardInDecklist
        WHERE deckId = :decklistId;
    
        DELETE FROM decklist
        WHERE id = :decklistId;
    SQL;
    $replacements = array(
        'decklistId' => ['value' => $decklistId, 'type' => PDO::PARAM_INT]
    );
    $database->query($sql, $replacements);
    return $database->responseSuccess(array(
        'decklistId' => $decklistId
    ));
}

$database = new Database();
$database->handleRequest('getDecklist', 'postDecklist', 'putDecklist', 'deleteDecklist');
