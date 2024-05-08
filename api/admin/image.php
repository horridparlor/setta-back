<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");

const ASSETS_PATH = "../../../setta-assets/";
function postImage(Database $database): string
{
    $expansionId = $database->getIntParam('expansionId');
    $imageName = $database->getStringParam('imageName');
    $imageMime = $database->getStringParam('imageMime');
    $base64String = $database->getStringParam('base64String');

    $fileExtension = 'png';
    if ($imageMime === 'image/webp') {
        $fileExtension = 'webp';
    }
    $imageData = base64_decode($base64String);
    $fullfSizePath = ASSETS_PATH . 'card-art/' . $expansionId . '/' . $imageName . '.' . $fileExtension;
    file_put_contents($fullfSizePath, $imageData);
    switch ($fileExtension) {
        case 'png':
            $img = imagecreatefrompng($fullfSizePath);
            break;
        case 'webp':
            $img = imagecreatefromwebp($fullfSizePath);
            break;
        default:
            return $database->responseUnsupported(array(
                'error' => 'Unsupported image type: ' . $fileExtension,
            ));
    }
    $smallImg = imagescale($img, 256, 256);

    $smallPath = ASSETS_PATH . 'small-art/' . $expansionId . '/' . $imageName . '.png';
    imagepng($smallImg, $smallPath);

    imagedestroy($img);
    imagedestroy($smallImg);

    return $database->responseSuccess(array(
        'imagePath' => './images/' . $imageName . '.png',
    ));
}


$database = new Database();
$database->handleRequest(null, 'postImage');