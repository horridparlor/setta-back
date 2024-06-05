<?php

use system\Database;

const ASSETS_PATH = "../../../setta-assets/";
const THUMBNAILS_PATH = "../../../setta-assets/small-art/";
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
    return $base . '/' . $ownerId . '/';
}
function getThumbnailFolderPath(int $ownerId, int $cardId): string {
    $base = ASSETS_PATH . 'small-art/' . $cardId . '/';
    if (!file_exists($base)) {
        mkdir($base, 0777, true);
    }
    return $base . '/' . $ownerId . '/';
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
    $imageWidth = imagesx($img);
    $imageHeight = imagesy($img);
    $originalSize = min($imageWidth, $imageHeight);
    if ($imageWidth > $imageHeight) {
        $originalSize = WIDTH_MULTIPLIER * $originalSize;
    }
    $imageScale = 1 + $artScale / (SCALE_MULTIPLIER * PIXELS_PER_REM);
    $xOffset = $artXOffset * (PIXELS_PER_REM * OFFSET_MULTIPLIER / IMAGE_WIDTH) * $originalSize / $imageScale;
    $yOffset = $artYOffset * (PIXELS_PER_REM * OFFSET_MULTIPLIER / IMAGE_WIDTH) * $originalSize / $imageScale;
    $cropRect = array(
        'x' => $xOffset,
        'y' => $yOffset,
        'width' => $originalSize / $imageScale,
        'height' => HEIGHT_MULTIPLIER * $originalSize / $imageScale,
    );
    $croppedImg = imagecrop($img, $cropRect);
    if ($croppedImg === FALSE) {
        $croppedImg = $img;
    }
    $smallImg = imagescale($croppedImg, RESULT_SCALE * IMAGE_WIDTH, RESULT_SCALE * IMAGE_HEIGHT);

    $smallPath = getThumbnailFolderPath($ownerId, $cardId);
    if (!file_exists($smallPath)) {
        mkdir($smallPath, 0777, true);
    }
    $smallPath .= $imageName . '.webp';

    imagewebp($smallImg, $smallPath);

    imagedestroy($img);
    imagedestroy($croppedImg);
    imagedestroy($smallImg);
    return '';
}

function renameCardArt(string $oldName, string $newName, int $ownerId, int $cardId): string|null {
    return copyCardArt($oldName, $newName, $ownerId, $cardId, $cardId, true);
}

function copyCardArt(string $oldName, string $newName, int $ownerId, int $cardId, int $newCardId, bool $doCut = false): string|null {
    $oldFullSizePath = getFullSizePath($ownerId, $cardId, $oldName);
    $newFullSizeName = getFullSizePath($ownerId, $newCardId, $newName);
    $oldThumbnailPath = getThumbnailPath($ownerId, $cardId, $oldName);
    $newThumbnailPath = getThumbnailPath($ownerId, $newCardId, $newName);
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

function copyErrataArtwork(int $newId, Database $database): string {
    $sql = <<<SQL
        SELECT oldCard.id oldId, oldCard.normalizedName normalizedName, oldCard.ownerId ownerId
        FROM card newCard
        JOIN card oldCard
            ON oldCard.id = newCard.errataOfId
        WHERE newCard.id = :newId
    SQL;
    $replacements = array(
        'newId' => ['value' => $newId, 'type' => PDO::PARAM_INT],
    );
    $result = $database->query($sql, $replacements)[0];
    $oldId = $result['oldId'];
    $nowmalizedName = $result['normalizedName'];
    $ownerId = $result['ownerId'];

    return copyCardArt($nowmalizedName, $nowmalizedName, $ownerId, $oldId, $newId);
}