
with top10_old_groups as (select hk_group_id
                          from STV2024012266__DWH.h_groups
                          order by registration_dt
                          limit 10)
   , messages_from_top10_old_groups as (select lgd.hk_message_id
                                        from STV2024012266__DWH.l_groups_dialogs lgd
                                                 inner join top10_old_groups t10og on t10og.hk_group_id = lgd.hk_group_id)
   , users_write_messages_from_top10_old_groups as (select distinct lum.hk_user_id
                                                    from messages_from_top10_old_groups mft10og
                                                             inner join STV2024012266__DWH.l_user_message lum
                                                                        on lum.hk_message_id = mft10og.hk_message_id)
-- select count(*) from users_write_messages_from_top10_old_groups;
select sus.age, count(1)
from STV2024012266__DWH.s_user_socdem sus
         inner join users_write_messages_from_top10_old_groups uwmft10og on uwmft10og.hk_user_id = sus.hk_user_id
group by sus.age
order by 2 desc
;



select hk_group_id
from STV2024012266__DWH.h_groups
order by registration_dt limit 10;

-- 7757992142189260835
-- 6014017525933240454
-- 7279971728630971062
-- 5568963519328366880
-- 206904954090724337
-- 9183043445192227260
-- 7174329635764732197
-- 2461736748292367987
-- 3214410852649090659
-- 4350425024258480878



select hk_message_id
from MY__DWH.l_groups_dialogs
where hk_group_id in (select hk_group_id
                    from MY__DWH.h_groups
                    order by registration_dt limit 10)


    age  count
0    22     41
1    19     36
2    20     36
3    21     29
4    18     26
5    60     25
6    56     21
7    55     19
8    62     19
9    63     18
10   27     17
11   58     17
12   64     17
13   59     16
14   57     16
15   30     16
16   34     16
17   43     15
18   42     14




select age
        ,count(1)
from STV2024012266__DWH.s_user_socdem
where hk_user_id in (select hk_user_id
                        from STV2024012266__DWH.l_user_message
                        where hk_message_id in (select hk_message_id
                                                from STV2024012266__DWH.l_groups_dialogs
                                                where hk_group_id in (select hk_group_id
                                                                    from STV2024012266__DWH.h_groups
                                                                    order by registration_dt limit 10)))
group by age
order by 2 desc