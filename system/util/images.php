<?php

use system\Database;

const ASSETS_PATH = "../../../setta-assets/";
const THUMBNAILS_PATH = "../../../setta-assets/small-art/";
const FILE_EXTENSION = 'png';
const IMAGE_WIDTH = 108;
const IMAGE_HEIGHT = 96;
const WIDTH_MULTIPLIER = IMAGE_WIDTH / IMAGE_HEIGHT;

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
    $scaledHeight = (1 + $artScale / 24) * $imageHeight;
    $actualHeight = ($imageHeight / $scaledHeight) * $imageHeight;
    $cropRect = array(
        'x' => 6 * $artXOffset,
        'y' => 6 * $artYOffset,
        'width' => min(WIDTH_MULTIPLIER * $actualHeight + $artXOffset, $imageWidth),
        'height' => min($actualHeight + $artYOffset, $imageHeight),
    );
    $croppedImg = imagecrop($img, $cropRect);
    if ($croppedImg === FALSE) {
        $croppedImg = $img;
    }
    $smallImg = imagescale($croppedImg, 256, 256);

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