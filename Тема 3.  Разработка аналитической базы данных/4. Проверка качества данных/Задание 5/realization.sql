(SELECT
    max(u.registration_dt) < now() as 'no future dates',
    min(u.registration_dt) > '2020-09-03'::date as 'no false-start dates',
    'users' as dataset
FROM STV2024012266__STAGING.users u)
UNION ALL
(SELECT
    max(g.registration_dt) < now() as 'no future dates',
    min(g.registration_dt) > '2020-09-03'::date as 'no false-start dates',
    'groups'
FROM STV2024012266__STAGING.groups g)
UNION ALL
(SELECT
    max(d.message_ts) < now() as 'no future dates',
    min(d.message_ts) > '2020-09-03'::date as 'no false-start dates',
    'dialogs'
FROM STV2024012266__STAGING.dialogs d);