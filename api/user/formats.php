<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/sql/selectFormat.php");

function getExpansions(Database $database): string
{
    $formats = $database->query(SELECT_FORMAT_SQL);
    return $database->responseSuccess(array(
        'countOfFormats' => count($formats),
        'formats' => $formats,
    ));
}

$database = new Database();
$database->handleRequest('getExpansions');

