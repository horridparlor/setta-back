<?php

use system\Database;

const ASSETS_PATH = "../../../setta-assets/";
const THUMBNAILS_PATH = "../../../setta-assets/small-art/";
const FILE_EXTENSION = 'png';
const IMAGE_WIDTH = 108;
const IMAGE_HEIGHT = 96;
const PIXELS_PER_REM = 8;
const HEIGHT_MULTIPLIER = IMAGE_HEIGHT / IMAGE_WIDTH;
const RESULT_SIZE = 256;

function getFullSizeFolderPath(int $ownerId): string {
    return ASSETS_PATH . 'card-art/' . $ownerId . '/';
}
function getFullSizePath(int $ownerId, string $imageName): string {
    return getFullSizeFolderPath($ownerId) . $imageName . '.' . FILE_EXTENSION;
}

function updateThumbnail(
    int $ownerId,
    string $imageName,
    float $artScale,
    float $artXOffset,
    float $artYOffset,
    Database $database
): string {
    $fullSizePath = getFullSizePath($ownerId, $imageName);
    if (!file_exists($fullSizePath)) {
        return $database->responseNotFound(array(
           'error' => 'Full size image not found, cannot make thumbnail'
        ));
    }
    $fileInfo = finfo_open(FILEINFO_MIME_TYPE);
    $imageMime = finfo_file($fileInfo, $fullSizePath);
    finfo_close($fileInfo);
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
    $imageScale = (1 + $artScale / (4 * PIXELS_PER_REM));
    $actualHeight = ($imageHeight / ($imageScale * $imageHeight)) * $imageHeight;
    $actualWidth = ($imageWidth / ($imageScale * $imageWidth)) * $imageWidth * HEIGHT_MULTIPLIER;
    $xOffset = PIXELS_PER_REM * $artXOffset * $imageScale;
    $yOffset = PIXELS_PER_REM * $artYOffset * $imageScale * HEIGHT_MULTIPLIER;
    $cropRect = array(
        'x' => $xOffset,
        'y' => $yOffset,
        'width' => min($actualWidth + $xOffset, $imageWidth),
        'height' => min(HEIGHT_MULTIPLIER * $actualHeight + $yOffset, $imageHeight),
    );
    $croppedImg = imagecrop($img, $cropRect);
    if ($croppedImg === FALSE) {
        $croppedImg = $img;
    }
    $smallImg = imagescale($croppedImg, RESULT_SIZE,   RESULT_SIZE);

    $smallPath = THUMBNAILS_PATH . $ownerId . '/';
    if (!file_exists($smallPath)) {
        mkdir($smallPath, 0777, true);
    }
    $smallPath .= $imageName . '.png';

    imagepng($smallImg, $smallPath);

    imagedestroy($img);
    imagedestroy($croppedImg);
    imagedestroy($smallImg);
    return '';
}