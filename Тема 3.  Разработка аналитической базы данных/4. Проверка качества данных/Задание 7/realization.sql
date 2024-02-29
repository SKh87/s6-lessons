(SELECT count(1), 'missing group admin info' as info
FROM STV2024012266__STAGING.groups g
left JOIN STV2024012266__STAGING.users u on g.admin_id = u.id
WHERE u.id is null)
UNION ALL
(SELECT COUNT(1), 'missing sender info'
FROM STV2024012266__STAGING.dialogs d
left JOIN STV2024012266__STAGING.users u on d.message_from = u.id
WHERE u.id is null)
UNION ALL
(SELECT COUNT(1), 'missing receiver info'
FROM STV2024012266__STAGING.dialogs d
left JOIN STV2024012266__STAGING.users u on d.message_to = u.id
WHERE u.id is null)
UNION ALL
(SELECT COUNT(1), 'norm receiver info'
FROM STV2024012266__STAGING.dialogs d
left JOIN STV2024012266__STAGING.users u on d.message_to = u.id
WHERE u.id is not null);