drop table if exists STV2024012266__DWH.h_users;

create table STV2024012266__DWH.h_users
(
    hk_user_id      bigint primary key,
    user_id         int,
    registration_dt datetime,
    load_dt         datetime,
    load_src        varchar(20)
)
    order by load_dt
    SEGMENTED BY hk_user_id all nodes
    PARTITION BY load_dt::date
        GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2)
;


drop table if exists STV2024012266__DWH.h_dialogs;
create table STV2024012266__DWH.h_dialogs
(
    hk_message_id int,
    message_id    int,
    message_ts    timestamp(6),
    load_dt       datetime,
    load_src      varchar(20),
    constraint h_dialogs_pk primary key (hk_message_id)
)
    order by load_dt
    SEGMENTED BY hk_message_id all nodes
    PARTITION BY load_dt::date
        GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2)
;


drop table if exists STV2024012266__DWH.h_groups;

create table STV2024012266__DWH.h_groups
(
    hk_group_id     int,
    group_id        int,
    registration_dt timestamp(6),
    load_dt         datetime,
    load_src        varchar(20),
    constraint h_groups_pk primary key (hk_group_id)
)
    order by load_dt
    SEGMENTED BY hk_group_id all nodes
    PARTITION BY load_dt::date
        GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2)
;