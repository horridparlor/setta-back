<?php

use system\Database;

const ASSETS_PATH = "../../../setta-assets/";
const PIXELS_PER_REM = 16;
const OFFSET_MULTIPLIER = 0.25;
const SCALE_MULTIPLIER = 2;
const IMAGE_WIDTH = 27 * PIXELS_PER_REM;
const IMAGE_HEIGHT = 24 * PIXELS_PER_REM;
const WIDTH_MULTIPLIER = IMAGE_WIDTH / IMAGE_HEIGHT;
const HEIGHT_MULTIPLIER = IMAGE_HEIGHT / IMAGE_WIDTH;
const RESULT_SCALE = 2.5;
function getFullSizeFolderPath(int $ownerId, int $cardId): string {
    $base = ASSETS_PATH . 'card-art/' . $cardId . '/';
    if (!file_exists($base)) {
        mkdir($base, 0777, true);
    }
    $path = $base . $ownerId . '/';
    if (!file_exists($path)) {
        mkdir($path, 0777, true);
    }
    return $path;
}
function getThumbnailFolderPath(int $ownerId, int $cardId): string {
    $base = ASSETS_PATH . 'small-art/' . $cardId . '/';
    if (!file_exists($base)) {
        mkdir($base, 0777, true);
    }
    $path = $base . $ownerId . '/';
    if (!file_exists($path)) {
        mkdir($path, 0777, true);
    }
    return $path;
}
function getFullSizePath(int $ownerId, int $cardId, string $imageName): string {
    return getFullSizeFolderPath($ownerId, $cardId) . $imageName;
}

function getThumbnailPath(int $ownerId, int $cardId, string $imageName): string {
    return getThumbnailFolderPath($ownerId, $cardId) . $imageName . '.webp';
}

function updateThumbnail(
    int $ownerId,
    int $cardId,
    string $imageName,
    float $artScale,
    float $artXOffset,
    float $artYOffset,
    Database $database
): string {
    $fullSizePath = getFullSizePath($ownerId, $cardId, $imageName);
    echo 111;
    if (!file_exists($fullSizePath)) {
        return $database->responseNotFound(array(
           'error' => 'Full size image not found, cannot make thumbnail'
        ));
    }
    echo 2222;
    $fileInfo = finfo_open(FILEINFO_MIME_TYPE);
    echo 333;
    $imageMime = finfo_file($fileInfo, $fullSizePath);
    echo 444;
    finfo_close($fileInfo);
    echo 555;
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
            echo 99;
            $img = imagecreatefromwebp($fullSizePath);
            break;
        default:
            echo 1717;
            return $database->responseUnsupported(array(
                'error' => 'Unsupported image type: ' . $imageMime,
            ));
    }
    echo 2727;
    $imageWidth = imagesx($img);
    $imageHeight = imagesy($img);
    echo 3737;
    $originalSize = min($imageWidth, $imageHeight);
    if ($imageWidth > $imageHeight) {
        $originalSize = WIDTH_MULTIPLIER * $originalSize;
    }
    echo 4747;
    $imageScale = 1 + $artScale / (SCALE_MULTIPLIER * PIXELS_PER_REM);
    $xOffset = $artXOffset * (PIXELS_PER_REM * OFFSET_MULTIPLIER / IMAGE_WIDTH) * $originalSize / $imageScale;
    $yOffset = $artYOffset * (PIXELS_PER_REM * OFFSET_MULTIPLIER / IMAGE_WIDTH) * $originalSize / $imageScale;
    echo 5757;
    $cropRect = array(
        'x' => $xOffset,
        'y' => $yOffset,
        'width' => $originalSize / $imageScale,
        'height' => HEIGHT_MULTIPLIER * $originalSize / $imageScale,
    );
    echo 6767;
    $croppedImg = imagecrop($img, $cropRect);
    if ($croppedImg === FALSE) {
        $croppedImg = $img;
    }
    echo 8787;
    $smallImg = imagescale($croppedImg, RESULT_SCALE * IMAGE_WIDTH, RESULT_SCALE * IMAGE_HEIGHT);

    echo 9797;
    $smallPath = getThumbnailFolderPath($ownerId, $cardId);
    if (!file_exists($smallPath)) {
        mkdir($smallPath, 0777, true);
    }
    echo 1515;
    $smallPath .= $imageName . '.webp';

    imagewebp($smallImg, $smallPath);

    echo 2525;
    imagedestroy($img);
    imagedestroy($croppedImg);
    imagedestroy($smallImg);
    return '';
}

function renameCardArt(string $oldName, string $newName, int $ownerId, int $cardId): string|null {
    return copyCardArt($oldName, $newName, $ownerId, $ownerId, $cardId, $cardId, true);
}

function copyCardArt(string $oldName, string $newName, int $oldOwnerId, int $newOwnerId, int $cardId, int $newCardId, bool $doCut = false): string|null {
    $oldFullSizePath = getFullSizePath($oldOwnerId, $cardId, $oldName);
    $newFullSizeName = getFullSizePath($newOwnerId, $newCardId, $newName);
    $oldThumbnailPath = getThumbnailPath($oldOwnerId, $cardId, $oldName);
    $newThumbnailPath = getThumbnailPath($newOwnerId, $newCardId, $newName);
    if (file_exists($oldFullSizePath)) {
        if ($doCut ? !rename($oldFullSizePath, $newFullSizeName) : !copy($oldFullSizePath, $newFullSizeName)) {
            return "Failed to rename full-size image from $oldFullSizePath to $newFullSizeName";
        }
    } else {
       return "Full-size image not found at $oldFullSizePath";
    }
    if (file_exists($oldThumbnailPath)) {
        if ($doCut ? !rename($oldThumbnailPath, $newThumbnailPath) : !copy($oldThumbnailPath, $newThumbnailPath)) {
            return "Failed to rename thumbnail image from $oldThumbnailPath to $newThumbnailPath";
        }
    } else {
        return "Thumbnail image not found at $oldThumbnailPath";
    }
    return null;
}

function copyArtwork(int $oldId, int $newId, Database $database, bool $doErrata = false): string|null {
    $sql = <<<SQL
        SELECT oldCard.id oldId, oldCard.serializedName serializedName, oldCard.ownerId oldOwnerId, newCard.ownerId newOwnerId
        FROM card newCard
        JOIN card oldCard
            ON oldCard.id = :oldId
        WHERE newCard.id = :newId
    SQL;
    $replacements = array(
        'newId' => ['value' => $newId, 'type' => PDO::PARAM_INT],
        'oldId' => ['value' => $oldId, 'type' => PDO::PARAM_INT],
    );

    $result = $database->query($sql, $replacements)[0];
    $oldId = $result['oldId'];
    $serializedName = $result['serializedName'];
    $oldOwnerId = $result['oldOwnerId'];
    $newOwnerId = $result['newOwnerId'];

    return copyCardArt($serializedName, $serializedName, $oldOwnerId, $newOwnerId, $oldId, $newId);
}