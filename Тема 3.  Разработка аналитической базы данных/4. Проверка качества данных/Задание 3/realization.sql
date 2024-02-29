SELECT COUNT(distinct hash(g.group_name)), count(*)
FROM STV2024012266__STAGING.groups g;

-- explain
-- SELECT COUNT(distinct (g.group_name)), count(*)
-- FROM STV2024012266__STAGING.groups g;