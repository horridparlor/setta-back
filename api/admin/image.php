<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include("../../system/util/images.php");

function postImage(Database $database): string
{
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized();
    }

    $ownerId = $database->getIntParam('ownerId');
    $imageName = $database->getStringParam('imageName');
    $imageMime = $database->getStringParam('imageMime');
    $artScale = $database->getFloatParam('artScale');
    $artXOffset = $database->getFloatParam('artXOffset');
    $artYOffset = $database->getFloatParam('artYOffset');
    $base64String = $database->getRawStringParam('base64String');

    $imageData = base64_decode($base64String);
    $fullSizeFolder = getFullSizeFolderPath($ownerId);
    if (!file_exists($fullSizeFolder)) {
        mkdir($fullSizeFolder, 0777, true);
    }
    $fullSizePath = getFullSizePath($ownerId, $imageName);

    file_put_contents($fullSizePath, $imageData);

    $error = updateThumbnail($ownerId, $imageName, $artScale, $artXOffset, $artYOffset, $database);
    if (strlen($error)) {
        return $error;
    }

    return $database->responseSuccess(array(
        'imagePath' => ASSETS_PATH . 'card-art/' . $imageName . '.png',
    ));
}



$database = new Database();
$database->handleRequest(null, 'postImage');