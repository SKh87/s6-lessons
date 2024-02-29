drop table if exists STV2024012266__DWH.l_user_message;

create table STV2024012266__DWH.l_user_message
(
    hk_l_user_message bigint primary key,
    hk_user_id        bigint not null,
    hk_message_id     bigint not null,
    load_dt           datetime,
    load_src          varchar(20),
    CONSTRAINT fk_l_user_message_user foreign key (hk_user_id) REFERENCES STV2024012266__DWH.h_users (hk_user_id),
    CONSTRAINT fk_l_user_message_message foreign key (hk_message_id) REFERENCES STV2024012266__DWH.h_dialogs (hk_message_id)
)
    order by load_dt
    SEGMENTED BY hk_user_id all nodes
    PARTITION BY load_dt::date
        GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);


drop table if exists STV2024012266__DWH.l_admins;
create table STV2024012266__DWH.l_admins
(
    hk_l_admin_id int,
    hk_user_id  int not null,
    hk_group_id int not null,
    load_dt     datetime,
    load_src    varchar(20),
    constraint pk_l_admins primary key (hk_l_admin_id),
    constraint fk_l_admins_user foreign key (hk_user_id) references STV2024012266__DWH.h_users (hk_user_id),
    constraint fk_l_admins_group foreign key (hk_group_id) references STV2024012266__DWH.h_groups (hk_group_id)
)
order by load_dt
    SEGMENTED BY hk_l_admin_id all nodes
    PARTITION BY load_dt::date
        GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);

drop table if exists STV2024012266__DWH.l_groups_dialogs;

create table STV2024012266__DWH.l_groups_dialogs
(
    hk_l_groups_dialogs int,
    hk_message_id       int not null,
    hk_group_id         int not null,
    load_dt             datetime,
    load_src            varchar(20),
    constraint pk_l_groups_dialogs primary key (hk_l_groups_dialogs),
    constraint fk_l_groups_dialogs_message foreign key (hk_message_id) references STV2024012266__DWH.h_dialogs (hk_message_id),
    constraint fk_l_groups_dialogs_group foreign key (hk_group_id) references STV2024012266__DWH.h_groups (hk_group_id)
)
order by load_dt
    SEGMENTED BY hk_l_groups_dialogs all nodes
    PARTITION BY load_dt::date
        GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);