<?php

namespace system;

class User
{
    private int $id;
    private string $username;
    private bool $isAdmin;

    public function __construct(int $id, string $username, bool $isAdmin)
    {
        $this->id = $id;
        $this->username = $username;
        $this->isAdmin = $isAdmin;
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
        return $this->isAdmin;
    }
}