<?php

use system\Database;
use system\AccessBlock;
use system\StandardType;
use system\SqlComparison;
use System\Entity\Gameplay\GameSession;
use System\Entity\Gameplay\Player;

header('Content-Type: application/json');

include("../../../system/Database.php");
include("../../../system/User.php");
include("../../../system/AccessBlock.php");
include("../../../system/sql/gameplay/selectGameSession.php");
include("../../../system/entity/gameplay/GameSession.php");
include("../../../system/entity/gameplay/Player.php");

function sendAction(Database $database): string {
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized($user?->getError());
    }
    $requiredParams = array(
        array(
            'param' => 'gameId',
            'type' => StandardType::ID,
            'exists' => new SqlComparison(RUNNING_GAME_SESSION_WITH_PLAYER_EXISTS, $user->getReplacements('userId'))
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $gameId = $database->getIntParam('gameId');
    $gameSession = GameSession::fromId($gameId, $database);

    return $database->responseSuccess($gameSession->output());
}


$database = new Database();
$database->handleRequest(null, 'sendAction');
