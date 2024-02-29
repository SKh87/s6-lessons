drop table if exists STV2024012266__DWH.s_admins;

create table STV2024012266__DWH.s_admins
(
    hk_admin_id bigint not null
        CONSTRAINT fk_s_admins_l_admins REFERENCES STV2024012266__DWH.l_admins (hk_l_admin_id),
    is_admin    boolean,
    admin_from  datetime,
    load_dt     datetime,
    load_src    varchar(20)
)
    order by load_dt
    SEGMENTED BY hk_admin_id all nodes
    PARTITION BY load_dt::date
        GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);


INSERT INTO STV2024012266__DWH.s_admins(hk_admin_id, is_admin, admin_from, load_dt, load_src)
select la.hk_l_admin_id,
       True  as is_admin,
       hg.registration_dt,
       now() as load_dt,
       's3'  as load_src
from STV2024012266__DWH.l_admins as la
         left join STV2024012266__DWH.h_groups as hg on la.hk_group_id = hg.hk_group_id;



drop table if exists STV2024012266__DWH.s_user_chatinfo;
create table STV2024012266__DWH.s_user_chatinfo
(
    hk_user_id int not null,
    chat_name  varchar(200),
    load_dt    datetime,
    load_src   varchar(20),
    constraint fk_s_user_chatinfo_h_users foreign key (hk_user_id) references STV2024012266__DWH.h_users (hk_user_id)
)
    order by load_dt
    segmented by hk_user_id all nodes
    partition by load_dt::date
        group by calendar_hierarchy_day(load_dt::date, 3, 2)
;

insert into STV2024012266__DWH.s_user_chatinfo(hk_user_id, chat_name, load_dt, load_src)
select hu.hk_user_id,
       u.chat_name,
       now() as load_dt,
       's3'  as load_src
from STV2024012266__STAGING.users u
         inner join STV2024012266__DWH.h_users hu on u.id = hu.user_id
;

drop table if exists STV2024012266__DWH.s_user_socdem;
create table STV2024012266__DWH.s_user_socdem
(
    hk_user_id int not null,
--     chat_name  varchar(200),
    country    varchar(100),
    age        int,
    load_dt    datetime,
    load_src   varchar(20),
    constraint fk_s_user_socdem_h_users foreign key (hk_user_id) references STV2024012266__DWH.h_users (hk_user_id)
)
    order by load_dt
    segmented by hk_user_id all nodes
    partition by load_dt::date group by calendar_hierarchy_day(load_dt::date, 3, 2)
;

insert into STV2024012266__DWH.s_user_socdem(hk_user_id,
--                                              chat_name,
                                             country, age, load_dt, load_src)
select hu.hk_user_id,
--        u.chat_name,
       u.country,
       u.age,
       now() as load_dt,
       's3'  as load_src
from STV2024012266__STAGING.users u
         inner join STV2024012266__DWH.h_users hu on u.id = hu.user_id
;


drop table if exists STV2024012266__DWH.s_group_private_status;
create table STV2024012266__DWH.s_group_private_status
(
    hk_group_id int not null,
    is_private  boolean,
    load_dt     datetime,
    load_src    varchar(20),
    constraint fk_s_group_private_status_h_groups foreign key (hk_group_id) references STV2024012266__DWH.h_groups (hk_group_id)
)
    order by load_dt
    segmented by hk_group_id all nodes
    partition by load_dt::date group by calendar_hierarchy_day(load_dt::date, 3, 2)
;

insert into STV2024012266__DWH.s_group_private_status(hk_group_id, is_private, load_dt, load_src)
select hg.hk_group_id,
       g.is_private,
       now() as load_dt,
       's3'  as load_src
from STV2024012266__STAGING.groups g
         inner join STV2024012266__DWH.h_groups hg on hg.group_id = g.id
;


drop table if exists STV2024012266__DWH.s_group_name;
create table STV2024012266__DWH.s_group_name
(
    hk_group_id int not null,
    group_name  varchar(100),
    load_dt     datetime,
    load_src    varchar(20),
    constraint fk_s_group_name_h_groups foreign key (hk_group_id) references STV2024012266__DWH.h_groups (hk_group_id)
)
    order by load_dt
    segmented by hk_group_id all nodes
    partition by load_dt::date group by calendar_hierarchy_day(load_dt::date, 3, 2)
;

insert into STV2024012266__DWH.s_group_name(hk_group_id, group_name, load_dt, load_src)
select hg.hk_group_id,
       g.group_name,
       now() as load_dt,
       's3'  as load_src
from STV2024012266__STAGING.groups g
         inner join STV2024012266__DWH.h_groups hg on hg.group_id = g.id
;

drop table if exists STV2024012266__DWH.s_dialog_info;
create table STV2024012266__DWH.s_dialog_info
(
    hk_message_id int not null,
    message       varchar(1000),
    message_from  int,
    message_to    int,
    load_dt       datetime,
    load_src      varchar(20),
    constraint fk_s_dialog_info_h_dialog foreign key (hk_message_id) references STV2024012266__DWH.h_dialogs (hk_message_id)
)
    order by load_dt
    segmented by hk_message_id all nodes
    partition by load_dt::date group by calendar_hierarchy_day(load_dt::date, 3, 2)
;

insert into STV2024012266__DWH.s_dialog_info(hk_message_id, message, message_from, message_to, load_dt, load_src)
select hd.hk_message_id,
       d.message,
       d.message_from,
       d.message_to,
       now() as load_dt,
       's3'  as load_src
from STV2024012266__STAGING.dialogs d
         inner join STV2024012266__DWH.h_dialogs hd on hd.message_id = d.message_id
;