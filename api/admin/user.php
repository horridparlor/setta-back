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
    if ($userId != $user->getId() && !$user->isAdmin()) {
        return $database->responseUnauthorized();
    }
    $sql = SELECT_USER . <<<SQL
        AND user.id = :userId
    SQL;
    $replacements = array(
        'userId' => ['value' => $userId, 'type' => PDO::PARAM_INT]
    );
    $user = $database->queryWithDecode($sql, USER_COLUMNS_TO_DECODE, $replacements);

    return $database->responseSuccess(array(
        'user' => $user[0]
    ));
}

function createNewRole(string|null $roleName, stdClass $accessRights, Database $database): int {
    $sql = <<<SQL
        INSERT INTO userRole (
            name,
            accessRights
        ) VALUES (
            :roleName,
            :accessRights 
        )
    SQL;
    $replacements = array(
        'roleName' => ['value' => $roleName, 'type' => PDO::PARAM_STR],
        'accessRights' => ['value' => json_encode($accessRights), 'type' => PDO::PARAM_STR]
    );
    $database->query($sql, $replacements);
    return $database->getInsertId();
}

function canGiveRole(User $user, stdClass $accessRights, Database $database): string|null {
    $dummyUser = User::newDummyUser($accessRights);
    if ($dummyUser->isAdmin()) {
        return Database::responseForbidden(array(
           'error' => 'New admins cannot be created'
        ));
    }
    if (!$user->isAdmin() && $dummyUser->hasAdminRights()) {
        return Database::responseUnauthorized(array(
           'error' => 'You cannot give admin access rights'
        ));
    }
    return null;
}

function canGiveExistingRole(User $user, int $roleId, Database $database): string|null {
    $sql = <<<SQL
        SELECT accessRights
        FROM userRole role
        WHERE role.id = :roleId
    SQL;
    $replacements = array(
        'roleId' => ['value' => $roleId, 'type' => PDO::PARAM_INT]
    );
    $accessRights = json_decode($database->query($sql, $replacements)[0]['accessRights']);
    return canGiveRole($user, $accessRights, $database);
}

function postUser(Database $database): string
{
    $user = $database->getUser();
    if (!$user || !$user->canManageUsers()) {
        return $database->responseUnauthorized();
    }
    $uniqueUsernameSql = <<<SQL
        SELECT :comparedValue
        FROM user
        WHERE username = :comparedValue
    SQL;
    $roleExistsSql = <<<SQL
        SELECT :comparedValue
        FROM DUAL
        WHERE NOT EXISTS (
            SELECT id
            FROM userRole
            WHERE id = :comparedValue
        )
    SQL;

    $requiredParams = array(
        array(
          'param' => 'username',
          'type' => StandardType::STRING,
          'unique' => new SqlComparison($uniqueUsernameSql)
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
            'type' => StandardType::BOOLEAN,
            'required' => false
        ),
        array(
            'param' => 'roleId',
            'type' => StandardType::NUMBER,
            'exists' => new SqlComparison($roleExistsSql),
            'option' => array(
                'param' => 'accessRights',
                'children' => array(
                    array(
                        'param' => 'isAdmin',
                        'type' => StandardType::BOOLEAN,
                        'forbidden' => true
                    ),
                    array(
                        'param' => 'canRelease',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canManageAdmins',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canManageUsers',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canClearContent',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'hasUnlimitedTokens',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canShareTokens',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canMessageAdmins',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canMassExport',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canCreateContent',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canGenerateImages',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canMessage',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'autoRefillTokens',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'isRegularUser',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'isPriorityUser',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'isEmployee',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'isContentCreator',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                )
            )
        ),
        array(
            'param' => 'roleName',
            'type' => StandardType::STRING,
            'required' => false
        )
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
    $roleName = $database->getStringParam('roleName');
    $accessRights = $database->getObjectParam('accessRights');
    if (is_null($roleId)) {
        $error = canGiveRole($user, $accessRights, $database);
        if ($error) {
            return $error;
        }
        $roleId = createNewRole($roleName, $accessRights, $database);
    } else {
        $error = canGiveExistingRole($user, $roleId, $database);
        if ($error) {
            return $error;
        }
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
            roleId
        ) VALUES (
            :username,
            :passwordHash, 
            :firstname,
            :lastname,
            :penName,
            :email,
            :phoneNumber,
            :isActive,
            :roleId
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
    );
    $database->query($sql, $replacements);
    $result = $database->query('SELECT LAST_INSERT_ID() userId;');

    return $database->responseSuccess(array(
        'userId' => $result[0]['userId']
    ));
}

function putUser(Database $database): string
{
    $user = $database->getUser();
    if (!$user || !$user->canManageUsers()) {
        return $database->responseUnauthorized();
    }
    $uniqueUsernameSql = <<<SQL
        SELECT :comparedValue
        FROM user
        WHERE username = :comparedValue
        AND NOT id = :userId
    SQL;
    $uniqueUsernameReplacements = array(
        'userId' => ['value' => '$userId', 'type' => PDO::PARAM_INT]
    );
    $roleExistsSql = <<<SQL
        SELECT :comparedValue
        FROM DUAL
        WHERE NOT EXISTS (
            SELECT id
            FROM userRole
            WHERE id = :comparedValue
        )
    SQL;

    $requiredParams = array(
        array(
            'param' => 'userId',
            'type' => StandardType::ID,
            'exists' => new SqlComparison(USER_EXISTS_SQL)
        ),
        array(
          'param' => 'username',
          'type' => StandardType::STRING,
          'unique' => new SqlComparison($uniqueUsernameSql, $uniqueUsernameReplacements, $database->getRequestData())
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
            'type' => StandardType::BOOLEAN,
            'required' => false
        ),
        array(
            'param' => 'roleId',
            'type' => StandardType::NUMBER,
            'exists' => new SqlComparison($roleExistsSql),
            'option' => array(
                'param' => 'accessRights',
                'children' => array(
                    array(
                        'param' => 'isAdmin',
                        'type' => StandardType::BOOLEAN,
                        'forbidden' => true
                    ),
                    array(
                        'param' => 'canRelease',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canManageAdmins',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canManageUsers',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canClearContent',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'hasUnlimitedTokens',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canShareTokens',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canMessageAdmins',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canMassExport',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canCreateContent',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canGenerateImages',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'canMessage',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'autoRefillTokens',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'isRegularUser',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'isPriorityUser',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'isEmployee',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                    array(
                        'param' => 'isContentCreator',
                        'type' => StandardType::BOOLEAN,
                        'required' => false
                    ),
                )
            )
        ),
        array(
            'param' => 'roleName',
            'type' => StandardType::STRING,
            'required' => false
        )
    );
    $missingParam = AccessBlock::findMissingParam($requiredParams, $database);
    if ($missingParam) {
        return $database->responseBadRequest($missingParam);
    }
    $userId = $database->getIntParam('userId');
    return $database->responseSuccess(array(
        'userId' => $userId
    ));
}

$database = new Database();
$database->handleRequest('getUser', 'postUser', 'putUser');
