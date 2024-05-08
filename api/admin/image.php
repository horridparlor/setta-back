<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");

const ASSETS_PATH = "../../../setta-assets/";
function postImage(Database $database): string
{
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized();
    }

    $ownerId = $database->getIntParam('ownerId');
    $imageName = $database->getStringParam('imageName');
    $imageMime = $database->getStringParam('imageMime');
    $base64String = $database->getRawStringParam('base64String');

    $fileExtension = 'png';
    if ($imageMime === 'image/webp') {
        $fileExtension = 'webp';
    }

    $imageData = base64_decode($base64String);
    $fullSizePath = ASSETS_PATH . 'card-art/' . $ownerId . '/';
    if (!file_exists($fullSizePath)) {
        mkdir($fullSizePath, 0777, true);
    }
    $fullSizePath .= $imageName . '.' . $fileExtension;

    file_put_contents($fullSizePath, $imageData);

    switch ($fileExtension) {
        case 'png':
            $img = imagecreatefrompng($fullSizePath);
            break;
        case 'webp':
            $img = imagecreatefromwebp($fullSizePath);
            break;
        default:
            return $database->responseUnsupported(array(
                'error' => 'Unsupported image type: ' . $fileExtension,
            ));
    }
    $smallImg = imagescale($img, 256, 256);

    // Prepare the path for small-sized images
    $smallPath = ASSETS_PATH . 'small-art/' . $ownerId . '/';
    if (!file_exists($smallPath)) {
        mkdir($smallPath, 0777, true);
    }
    $smallPath .= $imageName . '.png';

    imagepng($smallImg, $smallPath);

    imagedestroy($img);
    imagedestroy($smallImg);

    return $database->responseSuccess(array(
        'imagePath' => ASSETS_PATH . 'card-art/' . $imageName . '.png',
    ));
}



$database = new Database();
$database->handleRequest(null, 'postImage');