<?php

namespace system;

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
        if (!property_exists($this->accessRights, 'isAdmin')) {
            return false;
        }
        return $this->accessRights->isAdmin;
    }
}