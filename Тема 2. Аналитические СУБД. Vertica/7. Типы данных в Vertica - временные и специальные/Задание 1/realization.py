# create table STUDENT_SCHEMA.orders_v2
# (
#     id  int PRIMARY KEY,
#     registration_ts timestamptz(6),
#     user_id int,
#     is_confirmed boolean
# )
# ORDER BY id
# SEGMENTED BY HASH(id) ALL NODES
# ;

vertica_user = 'stv2024012266'