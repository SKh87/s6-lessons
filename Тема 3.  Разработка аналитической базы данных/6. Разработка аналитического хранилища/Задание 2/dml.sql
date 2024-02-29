INSERT INTO STV2024012266__DWH.h_users(hk_user_id, user_id, registration_dt, load_dt, load_src)
select hash(id)        as hk_user_id,
       id              as user_id,
       registration_dt as registration_dt,
       now()           as load_dt,
       's3'            as load_src
from STV2024012266__STAGING.users
where hash(id) not in (select hk_user_id from STV2024012266__DWH.h_users);

insert into STV2024012266__DWH.h_dialogs(hk_message_id, message_id, message_ts, load_dt, load_src)
SELECT hash(d.message_id) as hk_message_id,
       d.message_id       as message_id,
       d.message_ts       as message_ts,
       now()              as load_dt,
       's3'               as load_src
from STV2024012266__STAGING.dialogs d
where hash(d.message_id) not in (select hk_message_id from STV2024012266__DWH.h_dialogs)
;

insert into STV2024012266__DWH.h_groups(hk_group_id, group_id, registration_dt, load_dt, load_src)
select hash(g.id) as     hk_group_id,
       g.id       as     group_id,
       g.registration_dt registration_dt,
       now()             load_dt,
       's3'              load_src
from STV2024012266__STAGING.groups g
where hash(g.id) not in (select hk_group_id from STV2024012266__DWH.h_groups)
;