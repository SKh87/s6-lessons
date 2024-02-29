COPY STV2024012266.members (id, age, gender, email ENFORCELENGTH)
    FROM LOCAL 'C:\Users\skh\Documents\Projects\private\practicum\s6-lessons\Тема 2. Аналитические СУБД. Vertica\5. Запись данных в Vertica часть 2\Задание 2\members.csv'
    DELIMITER ';'
    REJECTED DATA AS TABLE STV2024012266.members_rej
;