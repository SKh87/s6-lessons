drop table if exists STV2024012266__STAGING.dialogs;
drop table if exists STV2024012266__STAGING.groups;
drop table if exists STV2024012266__STAGING.users;


create table STV2024012266__STAGING.dialogs
(
    message_id    int,
    message_ts    timestamp(9),
    message_from  int,
    message_to    int,
    message       varchar(1000),
    message_group int,
    constraint dialogs_pk primary key (message_id)
)
    ORDER BY message_id
PARTITION BY message_ts::date
GROUP BY calendar_hierarchy_day(message_ts::date, 3, 2)
;


create table STV2024012266__STAGING.groups
(
    id              int,
    admin_id        int,
    group_name      varchar(100),
    registration_dt timestamp(6),
    is_private      boolean,
    constraint groups_pk primary key (id)
)
    order by id, admin_id
PARTITION BY registration_dt::date
GROUP BY calendar_hierarchy_day(registration_dt::date, 3, 2)
;


create table STV2024012266__STAGING.users
(
    id              int,
    chat_name       varchar(200),
    registration_dt timestamp,
    country         varchar(200),
    age             int,
    constraint users_pk primary key (id)
)
    ORDER BY id
;