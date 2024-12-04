<?php

use system\Database;

const ASSETS_PATH = "../../setta-assets/";
const PIXELS_PER_REM = 16;
const OFFSET_MULTIPLIER = 0.25;
const SCALE_MULTIPLIER = 2;
const IMAGE_WIDTH = 27 * PIXELS_PER_REM;
const IMAGE_HEIGHT = 24 * PIXELS_PER_REM;
const WIDTH_MULTIPLIER = IMAGE_WIDTH / IMAGE_HEIGHT;
const HEIGHT_MULTIPLIER = IMAGE_HEIGHT / IMAGE_WIDTH;
const RESULT_SCALE = 2.5;

function getFullSizeRootFolder(int $cardId): string {
    return ASSETS_PATH . 'card-art/' . $cardId . '/';
}
function getFullSizeFolderPath(int $ownerId, int $cardId): string {
    $root = getFullSizeRootFolder($cardId);
    if (!file_exists($root)) {
        mkdir($root, 0777, true);
    }
    $path = $root . $ownerId . '/';
    if (!file_exists($path)) {
        mkdir($path, 0777, true);
    }
    return $path;
}
function getThumbnailRootFolder(int $cardId): string {
    return ASSETS_PATH . 'small-art/' . $cardId . '/';
}
function getThumbnailFolderPath(int $ownerId, int $cardId): string {
    $root = getThumbnailRootFolder($cardId);
    if (!file_exists($root)) {
        mkdir($root, 0777, true);
    }
    $path = $root . $ownerId . '/';
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
    };
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

function killFolder(string $folderPath): void {
    if (!file_exists($folderPath)) {
        return;
    }
    $files = array_diff(scandir($folderPath), ['.', '..']);
    foreach ($files as $file) {
        $filePath = $folderPath . DIRECTORY_SEPARATOR . $file;
        if (is_dir($filePath)) {
            killFolder($filePath);
        } else {
            unlink($filePath);
        }
    }
    rmdir($folderPath);
}

function deleteCardAssets(array $cards): void {
    foreach ($cards as $cardId) {
        killFolder(getFullSizeRootFolder($cardId));
        killFolder(getThumbnailRootFolder($cardId));
    }
}

function renameFolder(string $oldPath, string $newPath): void {
    if (!file_exists($oldPath) || !is_dir($oldPath)) {
       return;
    }
    if (!file_exists($newPath)) {
        mkdir($newPath, 0777, true);
    }
    $dirHandle = opendir($oldPath);
    if ($dirHandle) {
        while (($file = readdir($dirHandle)) !== false) {
            if ($file !== '.' && $file !== '..') {
                $oldFilePath = $oldPath . DIRECTORY_SEPARATOR . $file;
                $newFilePath = $newPath . DIRECTORY_SEPARATOR . $file;
                rename($oldFilePath, $newFilePath);
            }
        }
        closedir($dirHandle);
    }
    rmdir($oldPath);
}

function reclaimCardAssets(array $cards, int $oldOwnerId, int $newOwnerId): void {
    foreach ($cards as $cardId) {
        renameFolder(getFullSizeFolderPath($oldOwnerId, $cardId), getFullSizeFolderPath($newOwnerId, $cardId));
        renameFolder(getThumbnailFolderPath($oldOwnerId, $cardId), getThumbnailFolderPath($newOwnerId, $cardId));
    }
}
