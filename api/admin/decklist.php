<?php

use system\Database;
use system\AccessBlock;
use system\StandardType;
use system\SqlComparison;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include("../../system/AccessBlock.php");


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

    $requiredParams = array(
        array(
          'param' => 'username',
          'type' => StandardType::STRING,
          'unique' => new SqlComparison(NEW_USERNAME_SQL)
        ),
        array(
            'param' => 'password',
            'type' => StandardType::STRING
        ),
        array(
            'param' => 'firstname',
            'type' => StandardType::STRING
        ),
        array(
            'param' => 'lastname',
            'type' => StandardType::STRING
        ),
        array(
            'param' => 'penName',
            'type' => StandardType::STRING,
            'required' => false
        ),
        array(
            'param' => 'email',
            'type' => StandardType::STRING,
            'required' => false
        ),
        array(
            'param' => 'phoneNumber',
            'type' => StandardType::STRING,
            'required' => false
        ),
        array(
            'param' => 'isActive',
            'type' => StandardType::BOOLEAN,
            'required' => false
        ),
        getUserAccessRightsMissingParams()
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $ownerId;
    $formatId;
    $name;
    $isValid;
    $isPublished;

    return "222";
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
