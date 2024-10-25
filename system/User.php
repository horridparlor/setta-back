<?php

namespace system;

const ACCESS_RIGHT_IS_ADMIN = 'isAdmin';
const ACCESS_RIGHT_CAN_RELEASE = 'canRelease';
const ACCESS_RIGHT_CAN_MANAGE_ADMINS = 'canManageAdmins';
const ACCESS_RIGHT_CAN_MANAGE_USERS = 'canManageUsers';
const ACCESS_RIGHT_CAN_CLEAR_CONTENT = 'canClearContent';
const ACCESS_RIGHT_HAS_UNLIMITED_TOKENS = 'hasUnlimitedTokens';
const ACCESS_RIGHT_CAN_SHARE_TOKENS = 'canShareTokens';
const ACCESS_RIGHT_CAN_MESSAGE_ADMINS = 'canMessageAdmins';
const ACCESS_RIGHT_CAN_MASS_EXPORT = 'canMassExport';
const ACCESS_RIGHT_CAN_CREATE_CONTENT = 'canCreateContent';
const ACCESS_RIGHT_CAN_GENERATE_IMAGES = 'canGenerateImages';
const ACCESS_RIGHT_CAN_MESSAGE = 'canMessage';
const ACCESS_RIGHT_AUTO_REFILL_TOKENS = 'autoRefillTokens';
const ACCESS_RIGHT_IS_REGULAR_USER = 'isRegularUser';
const ACCESS_RIGHT_IS_PRIORITY_USER = 'isPriorityUser';
const ACCESS_RIGHT_IS_EMPLOYEE = 'isEmployee';
const ACCESS_RIGHT_IS_CONTENT_CREATOR = 'isContentCreator';

class User
{
    private int $id;
    private string $username;
    private \stdClass $accessRights;

    public function __construct(int $id, string $username, \stdClass $accessRights)
    {
        $this->id = $id;
        $this->username = $username;
        $this->accessRights = $accessRights;
    }

    public function getId(): int
    {
        return $this->id;
    }

    public function getUsername(): string
    {
        return $this->username;
    }

    public function isAdmin(): bool
    {
        return $this->hasAccessRight(ACCESS_RIGHT_IS_ADMIN);
    }
    public function canRelease(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_CAN_RELEASE);
    }
    public function canManageAdmins(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_CAN_MANAGE_ADMINS);
    }
    public function canManageUsers(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_CAN_MANAGE_USERS);
    }
    public function canClearContent(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_CAN_CLEAR_CONTENT);
    }
    public function hasUnlimitedTokens(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_HAS_UNLIMITED_TOKENS);
    }
    public function canShareTokens(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_CAN_SHARE_TOKENS);
    }
    public function canMessageAdmins(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_CAN_MESSAGE_ADMINS);
    }
    public function canMassExport(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_CAN_MASS_EXPORT);
    }
    public function canCreateContent(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_CAN_CREATE_CONTENT);
    }
    public function canGenerateImages(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_CAN_GENERATE_IMAGES);
    }
    public function canMessage(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_CAN_MESSAGE);
    }
    public function autoRefillTokens(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_AUTO_REFILL_TOKENS);
    }
    public function isRegularUser(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_IS_REGULAR_USER);
    }
    public function isPriorityUser(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_IS_PRIORITY_USER);
    }
    public function isEmployee(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_IS_EMPLOYEE);
    }
    public function isContentCreator(): bool
    {
        return $this->checkAccess(ACCESS_RIGHT_IS_CONTENT_CREATOR);
    }

    private function checkAccess(string $key): bool
    {
        return $this->isAdmin() || $this->hasAccessRight($key);
    }

    private function hasAccessRight(string $key): bool
    {
        if (!property_exists($this->accessRights, $key)) {
            return false;
        }
        return $this->accessRights->isAdmin;
    }
}