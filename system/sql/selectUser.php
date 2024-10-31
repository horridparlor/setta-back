<?php

const USER_COLUMNS_TO_DECODE = [
    'accessRights',
    'tokenRequest'
];

const USER_EXISTS_SQL = <<<SQL
    SELECT :comparedValue
    FROM DUAL
    WHERE NOT EXISTS (
        SELECT id
        FROM user
        WHERE id = :comparedValue
    )
SQL;

const SELECT_USER = <<<SQL
    SELECT
        user.id,
        username,
        firstname,
        lastname,
        penName,
        email,
        phoneNumber,
        isActive,
        roleId,
        CASE
            WHEN role.id IS NOT NULL THEN role.accessRights
            ELSE IFNULL(user.accessRights, "{}")
        END AS accessRights,
        CASE
            WHEN tr.id IS NOT NULL THEN JSON_OBJECT(
                'id', tr.id,
                'userId', tr.userId,
                'cardsInQueue', tr.cardsInQueue,
                'createdAt', tr.createdAt
            )
            ELSE null
        END AS tokenRequest
    FROM user
    LEFT JOIN userRole role
        ON role.id = user.roleId
    LEFT JOIN tokenRequest tr
        ON tr.userId = user.id
    WHERE user.id > 0
SQL;
