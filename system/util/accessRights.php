<?php

use system\StandardType;
use system\SqlComparison;
use system\Database;
use system\User;

function getUserAccessRightsMissingParams(): array {
    $roleExistsSql = <<<SQL
        SELECT :comparedValue
        FROM DUAL
        WHERE NOT EXISTS (
            SELECT id
            FROM userRole
            WHERE id = :comparedValue
        )
    SQL;
    return array(
        'param' => 'roleId',
        'type' => StandardType::ID,
        'exists' => new SqlComparison($roleExistsSql),
        'option' => getAccessRightsMissingParams()
    );
}

function canGiveExistingRole(User $user, int|null $roleId, Database $database): string|null {
    if (is_null($roleId)) {
        return null;
    }
    $accessRights = getAccessRightsByRoleId($roleId, $database);
    return canGiveRole($user, $accessRights, $database);
}

function getAccessRightsByRoleId(int $roleId, Database $database): stdClass {
    $sql = <<<SQL
        SELECT accessRights
        FROM userRole role
        WHERE role.id = :roleId
    SQL;
    $replacements = array(
        'roleId' => ['value' => $roleId, 'type' => PDO::PARAM_INT]
    );
    return json_decode($database->query($sql, $replacements)[0]['accessRights']);
}

function canAlterUserRights(User $user, User $editedUser, int|null $roleId, stdClass $accessRights, Database $database): string|null {
    $newAccessRights = $roleId ? getAccessRightsByRoleId($roleId, $database) : $accessRights;
    return canAlterRights($user, $editedUser, $newAccessRights, $database);
}

function canAlterRoleRights(User $user, int $roleId, stdClass $accessRights, Database $database): string|null {
    $oldRights = getAccessRightsByRoleId($roleId, $database);
    $dummyUser = User::newDummyUser($oldRights);
    return canAlterRights($user, $dummyUser, $accessRights, $database);
}

function canAlterRights(User $user, User $editedUser, stdClass $accessRights, Database $database): string|null {
    if ($user->canManageAdmins()) {
        return null;
    }
    if ($editedUser->wouldChangeAdminRights($accessRights)) {
        return Database::responseUnauthorized($editedUser->getError());
    }
    return null;
}

function canGiveRole(User $user, stdClass $accessRights, Database $database): string|null {
    $dummyUser = User::newDummyUser($accessRights);
    if ($dummyUser->isSuperAdmin()) {
        return Database::responseForbidden(array(
            'error' => 'New admins cannot be created'
        ));
    }
    if (!$user->isSuperAdmin() && $dummyUser->hasAdminRights()) {
        return Database::responseUnauthorized(array(
            'error' => sprintf('You cannot give admin access right {%s}', $dummyUser->getAdminAccessRight())
        ));
    }
    return null;
}

function getAccessRightsMissingParams(): array {
    return array(
        'param' => 'accessRights',
        'children' => array(
            array(
                'param' => 'isSuperAdmin',
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
            )
        )
    );
}
