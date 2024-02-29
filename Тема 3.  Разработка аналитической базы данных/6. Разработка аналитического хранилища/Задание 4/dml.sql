INSERT INTO STV2024012266__DWH.l_admins(hk_l_admin_id, hk_group_id, hk_user_id, load_dt, load_src)
select hash(hg.hk_group_id, hu.hk_user_id),
       hg.hk_group_id,
       hu.hk_user_id,
       now() as load_dt,
       's3'  as load_src
from STV2024012266__STAGING.groups as g
         left join STV2024012266__DWH.h_users as hu on g.admin_id = hu.user_id
         left join STV2024012266__DWH.h_groups as hg on g.id = hg.group_id
where hash(hg.hk_group_id, hu.hk_user_id) not in (select hk_l_admin_id from STV2024012266__DWH.l_admins);


insert into STV2024012266__DWH.l_groups_dialogs(hk_l_groups_dialogs, hk_message_id, hk_group_id, load_dt, load_src)
select hash(m.hk_message_id, g.hk_group_id) as hk_l_groups_dialogs,
       m.hk_message_id                      as hk_message_id,
       g.hk_group_id                        as hk_group_id,
       now()                                as load_dt,
       's3'                                 as load_src
from STV2024012266__STAGING.dialogs d
         inner join STV2024012266__DWH.h_groups g on g.group_id = d.message_group
         inner join STV2024012266__DWH.h_dialogs m on m.message_id = d.message_id
where hash(m.hk_message_id, g.hk_group_id) not in (select hk_l_groups_dialogs from STV2024012266__DWH.l_groups_dialogs)
;


insert into STV2024012266__DWH.l_user_message(hk_l_user_message, hk_user_id, hk_message_id, load_dt, load_src)
select hash(u.hk_user_id, m.hk_message_id) as hk_l_user_message,
       hk_user_id,
       hk_message_id,
       now()                                as load_dt,
       's3'                                 as load_src
from STV2024012266__STAGING.dialogs d
         inner join STV2024012266__DWH.h_dialogs m on m.message_id = d.message_id
         inner join STV2024012266__DWH.h_users u on u.user_id = d.message_from
where hash(u.hk_user_id, m.hk_message_id) not in (select hk_l_user_message from STV2024012266__DWH.l_user_message)
;