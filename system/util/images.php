<?php

use system\Database;

const ASSETS_PATH = "../../../setta-assets/";
const THUMBNAILS_PATH = "../../../setta-assets/small-art/";
const FILE_EXTENSION = 'png';
const PIXELS_PER_REM = 16;
const OFFSET_MULTIPLIER = 2.275;
const SCALE_MULTIPLIER = 2;
const ORIGINAL_SIZE = 1024;
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
        case 'image/jpeg':
            $img = imagecreatefromjpeg($fullSizePath);
            break;
        case 'image/gif':
            $img = imagecreatefromgif($fullSizePath);
            break;
        case 'image/webp':
            $img = imagecreatefromwebp($fullSizePath);
            break;
        default:
            return $database->responseUnsupported(array(
                'error' => 'Unsupported image type: ' . $imageMime,
            ));
    }
    $imageScale = 1 + $artScale / (SCALE_MULTIPLIER * PIXELS_PER_REM);
    $xOffset = PIXELS_PER_REM / OFFSET_MULTIPLIER * $artXOffset;
    $yOffset = PIXELS_PER_REM / OFFSET_MULTIPLIER * $artYOffset;
    $cropRect = array(
        'x' => $xOffset,
        'y' => $yOffset,
        'width' => ORIGINAL_SIZE / $imageScale,
        'height' => ORIGINAL_SIZE / $imageScale,
    );
    $croppedImg = imagecrop($img, $cropRect);
    if ($croppedImg === FALSE) {
        $croppedImg = $img;
    }
    $smallImg = imagescale($croppedImg, RESULT_SIZE, RESULT_SIZE);

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