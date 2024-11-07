<?php

use system\Database;
use system\AccessBlock;
use system\StandardType;
use system\SqlComparison;
use system\User;

header('Content-Type: application/json');

include("../../system/Database.php");
include("../../system/User.php");
include "../../system/sql/selectUser.php";
include("../../system/AccessBlock.php");
include("../../system/util/images.php");
include("../../system/util/accessRights.php");

function getUser(Database $database): string {
    $user = $database->getUser();
    if (!$user) {
        return $database->responseUnauthorized();
    }
    $requiredParams = array(
        array(
          'param' => 'userId',
          'type' => StandardType::ID,
          'exists' => new SqlComparison(USER_EXISTS_SQL)
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $userId = $database->getIntParam('userId', $user->getId());
    if (!$user->hasAccessToUser($userId)) {
        return $database->responseUnauthorized($user->getError());
    }
    $sql = SELECT_USER . <<<SQL
        AND user.id = :userId
    SQL;
    $replacements = array(
        'userId' => ['value' => $userId, 'type' => PDO::PARAM_INT]
    );
    $user = $database->queryWithDecode($sql, USER_COLUMNS_TO_DECODE, $replacements);

    return $database->responseSuccess($user[0]);
}

function postUser(Database $database): string
{
    $user = $database->getUser();
    if (!$user || !$user->canManageUsers()) {
        return $database->responseUnauthorized($user?->getError());
    }

    $requiredParams = array(
        array(
          'param' => 'username',
          'type' => StandardType::STRING,
          'unique' => new SqlComparison(NEW_USERNAME_SQL)
        ),
        array(
            'param' => 'password',
            'type' => StandardType::STRING
        ),
        array(
            'param' => 'firstname',
            'type' => StandardType::STRING
        ),
        array(
            'param' => 'lastname',
            'type' => StandardType::STRING
        ),
        array(
            'param' => 'penName',
            'type' => StandardType::STRING,
            'required' => false
        ),
        array(
            'param' => 'email',
            'type' => StandardType::STRING,
            'required' => false
        ),
        array(
            'param' => 'phoneNumber',
            'type' => StandardType::STRING,
            'required' => false
        ),
        array(
            'param' => 'isActive',
            'type' => StandardType::BOOLEAN,
            'required' => false
        ),
        getUserAccessRightsMissingParams()
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }

    $username = $database->getStringParam('username');
    $password = $database->getStringParam('password');
    $passwordHash = password_hash($password, PASSWORD_DEFAULT);

    $firstname = $database->getStringParam('firstname');
    $lastname = $database->getStringParam('lastname');
    $penName = $database->getStringParam('penName');
    $email = $database->getStringParam('email');
    $phoneNumber = $database->getStringParam('phoneNumber');
    $isActive = $database->getBooleanParam('isActive', true);
    $roleId = $database->getIntParam('roleId');
    $accessRights = $database->getObjectParam('accessRights');
    $error = canGiveRole($user, $accessRights, $database) ?? canGiveExistingRole($user, $roleId, $database);
    if ($error) {
        return $error;
    }
    $sql = <<<SQL
        INSERT INTO user (
            username,
            passwordHash,
            firstname,
            lastname,
            penName,
            email,
            phoneNumber,
            isActive,
            roleId,
            accessRights
        ) VALUES (
            :username,
            :passwordHash, 
            :firstname,
            :lastname,
            :penName,
            :email,
            :phoneNumber,
            :isActive,
            :roleId,
            :accessRights
        )
    SQL;
    $replacements = array(
        'username' => ['value' => $username, 'type' => PDO::PARAM_STR],
        'passwordHash' => ['value' => $passwordHash, 'type' => PDO::PARAM_STR],
        'firstname' => ['value' => $firstname, 'type' => PDO::PARAM_STR],
        'lastname' => ['value' => $lastname, 'type' => PDO::PARAM_STR],
        'penName' => ['value' => $penName, 'type' => PDO::PARAM_STR],
        'email' => ['value' => $email, 'type' => PDO::PARAM_STR],
        'phoneNumber' => ['value' => $phoneNumber, 'type' => PDO::PARAM_STR],
        'isActive' => ['value' => $isActive, 'type' => PDO::PARAM_BOOL],
        'roleId' => ['value' => $roleId, 'type' => PDO::PARAM_INT],
        'accessRights' => ['value' => json_encode($accessRights), 'type' => PDO::PARAM_STR]
    );
    $database->query($sql, $replacements);
    $result = $database->query('SELECT LAST_INSERT_ID() userId;');

    return $database->responseSuccess(array(
        'userId' => $result[0]['userId']
    ));
}

function updateUserRole(User $user, int $userId, int|null &$roleId,
                        stdClass $accessRights, Database $database): string|null
{
    $sql = <<<SQL
        SELECT role.id roleId, :accessRights
        FROM user
        JOIN userRole role
            ON role.id = user.roleId
        WHERE id = :userId
    SQL;
    $replacements = array(
        'userId' => ['value' => $userId, 'type' => PDO::PARAM_INT],
    );
    $previousAccessRights = $database->query($sql, $replacements)[0];
    if (intval($previousAccessRights['roleId']) == $roleId) {

    }
    return null;
}

function putUser(Database $database): string
{
    $user = $database->getUser();
    if (!$user || !$user->canManageUsers()) {
        return $database->responseUnauthorized($user?->getError());
    }

    $requiredParams = array(
        array(
            'param' => 'userId',
            'type' => StandardType::ID,
            'exists' => new SqlComparison(USER_EXISTS_SQL)
        ),
        array(
          'param' => 'username',
          'type' => StandardType::STRING,
          'unique' => new SqlComparison(UNIQUE_USERNAME_SQL, UNIQUE_USERNAME_REPLACEMENTS, $database->getRequestData())
        ),
        array(
            'param' => 'firstname',
            'type' => StandardType::STRING
        ),
        array(
            'param' => 'lastname',
            'type' => StandardType::STRING
        ),
        array(
            'param' => 'penName',
            'type' => StandardType::STRING,
            'required' => false
        ),
        array(
            'param' => 'email',
            'type' => StandardType::STRING,
            'required' => false
        ),
        array(
            'param' => 'phoneNumber',
            'type' => StandardType::STRING,
            'required' => false
        ),
        array(
            'param' => 'isActive',
            'type' => StandardType::BOOLEAN,
            'required' => false
        ),
        getUserAccessRightsMissingParams()
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $userId = $database->getIntParam('userId');
    $username = $database->getStringParam('username');
    $firstname = $database->getStringParam('firstname');
    $lastname = $database->getStringParam('lastname');
    $penName = $database->getStringParam('penName');
    $email = $database->getStringParam('email');
    $phoneNumber = $database->getStringParam('phoneNumber');
    $isActive = $database->getBooleanParam('isActive');
    $roleId = $database->getIntParam('roleId');
    $accessRights = $database->getObjectParam('accessRights');
    $editedUser = $database->findUser($userId);;
    $error = canAlterUserRights($user, $editedUser, $roleId, $accessRights, $database);
    if ($error) {
        return $error;
    }
    $sql = <<<SQL
        UPDATE user SET
            username = :username,
            firstname = :firstname,
            lastname = :lastname,
            penName = :penName,
            email = :email,
            phoneNumber = :phoneNumber,
            isActive = :isActive,
            roleId = :roleId,
            accessRights = :accessRights
        WHERE id = :userId
    SQL;
    $replacements = array(
        'userId' => ['value' => $userId, 'type' => PDO::PARAM_INT],
        'username' => ['value' => $username, 'type' => PDO::PARAM_STR],
        'firstname' => ['value' => $firstname, 'type' => PDO::PARAM_STR],
        'lastname' => ['value' => $lastname, 'type' => PDO::PARAM_STR],
        'penName' => ['value' => $penName, 'type' => PDO::PARAM_STR],
        'email' => ['value' => $email, 'type' => PDO::PARAM_STR],
        'phoneNumber' => ['value' => $phoneNumber, 'type' => PDO::PARAM_STR],
        'isActive' => ['value' => $isActive ?? $editedUser->getIsActive(), 'type' => PDO::PARAM_BOOL],
        'roleId' => ['value' => $roleId, 'type' => PDO::PARAM_INT],
        'accessRights' => ['value' => json_encode($accessRights), 'type' => PDO::PARAM_STR],
    );
    $database->query($sql, $replacements);


    return $database->responseSuccess(array(
        'userId' => $userId
    ));
}

function reclaimReleasedCards(int $userId, Database $database) {
    $replacements = array(
        'userId' => ['value' => $userId, 'type' => PDO::PARAM_INT],
    );
    $sql = <<<SQL
        SELECT card.id
        FROM card
        JOIN expansion
            ON expansion.id = card.expansionId
        WHERE card.ownerId = :userId
        AND expansion.isReleased = 1;
    SQL;
    $cardsToReclaim = $database->queryIds($sql, $replacements);
    reclaimCardAssets($cardsToReclaim, $userId, 1);
    $sql = <<<SQL
        UPDATE card
        JOIN expansion
            ON expansion.id = card.expansionId
        SET card.ownerId = 1
        WHERE card.ownerId = :userId
        AND expansion.isReleased = 1;
   SQL;
    $database->query($sql, $replacements);
}

function reclaimReleasedExpansions(User $user, int $userId, Database $database) {
   $sql = <<<SQL
        UPDATE expansion
        SET
            ownerId = 1,
            modifiedBy = :callingUserId,
            updatedAt = NOW()
        WHERE ownerId = :userId
        AND isReleased = 1;
        
        UPDATE expansion
        SET
            modifiedBy = :callingUserId
        WHERE modifiedBy = :userId;
   SQL;
   $replacements = array(
        'userId' => ['value' => $userId, 'type' => PDO::PARAM_INT],
        'callingUserId' => ['value' => $user->getId(), 'type' => PDO::PARAM_INT],
    );
   $database->query($sql, $replacements);
}

function deleteUsersContent(User $user, int $userId, Database $database) {
    reclaimReleasedCards($userId, $database);
    $sql = <<<SQL
        UPDATE card
        JOIN card deletedCard
            ON deletedCard.id = card.errataOfId
            OR deletedCard.id = card.primaryMaterialId
            OR deletedCard.id = card.secondaryMaterialId
            OR deletedCard.id = card.tertiaryMaterialId
            OR deletedCard.id = card.countsAsId
            OR deletedCard.id = card.modifiedBy
        SET 
            card.errataOfId = CASE
                WHEN card.errataOfId = deletedCard.id AND deletedCard.ownerId = :userId THEN NULL
                ELSE card.errataOfId
            END,
            card.primaryMaterialId = CASE
                WHEN card.primaryMaterialId = deletedCard.id AND deletedCard.ownerId = :userId THEN NULL
                ELSE card.primaryMaterialId
            END,
            card.secondaryMaterialId = CASE
                WHEN card.secondaryMaterialId = deletedCard.id AND deletedCard.ownerId = :userId THEN NULL
                ELSE card.secondaryMaterialId
            END,
            card.tertiaryMaterialId = CASE
                WHEN card.tertiaryMaterialId = deletedCard.id AND deletedCard.ownerId = :userId THEN NULL
                ELSE card.tertiaryMaterialId
            END,
            card.countsAsId = CASE
                WHEN card.countsAsId = deletedCard.id AND deletedCard.ownerId = :userId THEN NULL
                ELSE card.countsAsId
            END,
            card.modifiedBy = :callingUserId,
            card.updatedAt = NOW();
    SQL;
    $replacements = array(
        'userId' => ['value' => $userId, 'type' => PDO::PARAM_INT],
        'callingUserId' => ['value' => $user->getId(), 'type' => PDO::PARAM_INT],
    );
    $database->query($sql, $replacements);
    $sql = <<<SQL
        SELECT id
        FROM card
        WHERE ownerId = :userId 
    SQL;
    $replacements = array(
        'userId' => ['value' => $userId, 'type' => PDO::PARAM_INT],
    );
    $cardsToDelete = $database->queryIds($sql, $replacements);
    deleteCardAssets($cardsToDelete);
    $sql = <<<SQL
        UPDATE card
            SET
                errataOfId = NULL,
                primaryMaterialId = NULL,
                secondaryMaterialId = NULL,
                tertiaryMaterialId = NULL,
                countsAsId = NULL
        WHERE ownerId = :userId;
        
        DELETE
        FROM card
        WHERE ownerId = :userId
    SQL;
    $database->query($sql, $replacements);
    reclaimReleasedExpansions($user, $userId, $database);
    $sql = <<<SQL
        UPDATE card
        JOIN expansion
            ON expansion.id = card.expansionId
        SET expansionId = 8
        WHERE expansion.ownerId = :userId
    SQL;
    $database->query($sql, $replacements);
    $sql = <<<SQL
        DELETE
        FROM expansion
        WHERE ownerId = :userId
    SQL;
    $database->query($sql, $replacements);
}

function canDeleteUser(User $user, int $userId, bool $deleteAllTheirContent, Database $database): string|null {
    $editedUser = $database->findUser($userId);
    if (!$editedUser) {
        return $database->responseSuccess(array(
            'userId' => $userId
        ));
    }
    if (($editedUser->hasAdminRights() && !$user->canManageAdmins())
        || ($deleteAllTheirContent && !$user->canManageCards())
    ) {
        return $database->responseUnauthorized($user->getError());
    }
    if ($editedUser->getId() == $user->getId()) {
        return $database->responseForbidden(array('error' => 'Cannot delete yourself'));
    }
    if ($editedUser->isSuperAdmin()) {
        return $database->responseForbidden(array('error' => 'Cannot delete a super admin'));
    }
    return null;
}

function deleteUser (Database $database): string {
    $user = $database->getUser();
    if (!$user || !$user->canManageUsers() || !$user->canClearContent()) {
        return $database->responseUnauthorized($user?->getError());
    }
    $userCascadeReplacements = array(
        'cascadeCards' => ['value' => '$deleteAllTheirContent', 'type' => PDO::PARAM_BOOL],
        'cascadeExpansions' => ['value' => '$deleteAllTheirContent', 'type' => PDO::PARAM_BOOL]
    );
    $requiredParams = array(
        array (
            'param' => 'userId',
            'type' => StandardType::ID,
            'cascade' => new SqlComparison(USER_CASCADE_SQL, $userCascadeReplacements, $database->getRequestData())
        ),
        array (
            'param' => 'deleteAllTheirContent',
            'type' => StandardType::BOOLEAN,
            'required' => false
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $userId = $database->getIntParam('userId');
    $deleteAllTheirContent = $database->getBooleanParam('deleteAllTheirContent');
    $error = canDeleteUser($user, $userId, $deleteAllTheirContent, $database);
    if ($error) {
        return $error;
    }
    if ($deleteAllTheirContent) {
        deleteUsersContent($user, $userId, $database);
    }
    $sql = <<<SQL
        DELETE
        FROM authToken
        WHERE userId = :userId;
        
        DELETE
        FROM tokenRequest
        WHERE userId = :userId;
        
        DELETE
        FROM user
        WHERE id = :userId;
    SQL;
    $replacements = array(
        'userId' => ['value' => $userId, 'type' => PDO::PARAM_INT],
    );
    $database->query($sql, $replacements);
    return $database->responseSuccess(array(
        'userId' => $userId
    ));
}

$database = new Database();
$database->handleRequest('getUser', 'postUser', 'putUser', 'deleteUser');
