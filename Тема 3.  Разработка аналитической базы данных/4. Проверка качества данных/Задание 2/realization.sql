select count(distinct id) as total, count(*) as uniq, 'users' as dataset
from STV2024012266__STAGING.users
union all
select count(distinct id) as total, count(*) as uniq, 'groups' as dataset
from STV2024012266__STAGING.groups
union all
select count(distinct dialogs.message_id) as total, count(*) as uniq, 'dialogs' as dataset
from STV2024012266__STAGING.dialogs