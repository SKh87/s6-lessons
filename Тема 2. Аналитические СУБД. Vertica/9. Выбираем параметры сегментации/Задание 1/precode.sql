-- Прекод
drop table if exists STV2024012266.dialogs;
-- create table STV2024012266.dialogs
-- (
--     message_id   int PRIMARY KEY,
--     message_ts   timestamp(6),
--     message_from int REFERENCES users(id),
--     message_to int REFERENCES users(id),
--     message varchar(1000),
--     message_type varchar(100)
-- )
-- SEGMENTED BY hash(message_id) all nodes;


create table STV2024012266.dialogs
(
    message_id   int PRIMARY KEY,
    message_ts   timestamp(6),
    message_from int REFERENCES members(id),
    message_to int REFERENCES members(id),
    message varchar(1000),
    message_type varchar(100)
)
SEGMENTED BY hash(message_id) all nodes;