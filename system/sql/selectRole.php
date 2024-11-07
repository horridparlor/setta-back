<?php

const ROLE_COLUMNS_TO_DECODE = [
    'accessRights'
];

const NEW_ROLE_NAME_SQL = <<<SQL
    SELECT :comparedValue
    FROM userRole
    WHERE name = :comparedValue
SQL;

const UNIQUE_ROLE_NAME_SQL = <<<SQL
    SELECT :comparedValue
    FROM userRole
    WHERE name = :comparedValue
    AND NOT id = :roleId
SQL;

const UNIQUE_ROLE_NAME_REPLACEMENTS = array(
    'roleId' => ['value' => '$roleId', 'type' => PDO::PARAM_INT]
);

const ROLE_EXISTS_SQL = <<<SQL
    SELECT :comparedValue, "Role" entityType
    FROM DUAL
    WHERE NOT EXISTS (
        SELECT id
        FROM userRole
        WHERE id = :comparedValue
    )
SQL;

const ROLE_CASCADE_SQL = <<<SQL
    SELECT id cascadingId, username cascadingName, 'User' entityType
    FROM user
    WHERE roleId = :comparedValue
SQL;

const SELECT_ROLE = <<<SQL
    SELECT
        role.id,
        role.name,
        role.accessRights,
        role.createdAt,
        role.updatedAt
    FROM userRole role
SQL;