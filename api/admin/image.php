<?php

use system\Database;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");

const ASSETS_PATH = "../../../setta-assets/";
const IMAGE_WIDTH = 108;
const IMAGE_HEIGHT = 96;
const WIDTH_MULTIPLIER = IMAGE_WIDTH / IMAGE_HEIGHT;
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

    $fileExtension = 'png';

    $imageData = base64_decode($base64String);
    $fullSizePath = ASSETS_PATH . 'card-art/' . $ownerId . '/';
    if (!file_exists($fullSizePath)) {
        mkdir($fullSizePath, 0777, true);
    }
    $fullSizePath .= $imageName . '.' . $fileExtension;

    file_put_contents($fullSizePath, $imageData);

    switch ($imageMime) {
        case 'image/png':
            $img = imagecreatefrompng($fullSizePath);
            break;
        case 'image/webp':
            $img = imagecreatefromwebp($fullSizePath);
            break;
        default:
            return $database->responseUnsupported(array(
                'error' => 'Unsupported image type: ' . $imageMime,
            ));
    }
    $imageWidth = imagesx($img);
    $imageHeight = imagesy($img);
    $scaledHeight = (1 + $artScale / 32) * $imageHeight;
    $actualHeight = $imageHeight / $scaledHeight;
    $cropRect = array(
        'x' => $artXOffset,
        'y' => $artYOffset,
        'width' => min(WIDTH_MULTIPLIER * $actualHeight + $artXOffset, $imageWidth),
        'height' => min($actualHeight + $artYOffset, $imageHeight),
    );
    $croppedImg = imagecrop($img, $cropRect);
    if ($croppedImg === FALSE) {
        $croppedImg = $img;
    }
    $smallImg = imagescale($croppedImg, 256, 256);

    $smallPath = ASSETS_PATH . 'small-art/' . $ownerId . '/';
    if (!file_exists($smallPath)) {
        mkdir($smallPath, 0777, true);
    }
    $smallPath .= $imageName . '.png';

    imagepng($smallImg, $smallPath);

    imagedestroy($img);
    imagedestroy($croppedImg);
    imagedestroy($smallImg);

    return $database->responseSuccess(array(
        'imagePath' => ASSETS_PATH . 'card-art/' . $imageName . '.png',
    ));
}



$database = new Database();
$database->handleRequest(null, 'postImage');