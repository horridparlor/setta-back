<?php

const ROLE_COLUMNS_TO_DECODE = [
    'accessRights'
];


const ROLE_EXISTS_SQL = <<<SQL
    SELECT :comparedValue, "Role" entityType
    FROM DUAL
    WHERE NOT EXISTS (
        SELECT id
        FROM userRole
        WHERE id = :comparedValue
    )
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
