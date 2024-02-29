SELECT count(*)
FROM STV2024012266__STAGING.groups AS g
left join STV2024012266__STAGING.users AS u ON g.admin_id = u.id
WHERE u.id is null
;
/*
explain
SELECT count(*)
FROM STV2024012266__STAGING.groups AS g
left join STV2024012266__STAGING.users AS u ON g.admin_id = u.id
WHERE u.id is null
;

explain
SELECT count(*)
FROM STV2024012266__STAGING.groups AS g
WHERE g.admin_id not  in (select u.id from STV2024012266__STAGING.users u)
;


explain
SELECT count(*)
FROM STV2024012266__STAGING.groups AS g
WHERE not exists (select 1 from STV2024012266__STAGING.users u where u.id = g.admin_id)
;
*/