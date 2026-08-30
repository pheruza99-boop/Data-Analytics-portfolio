#Используя данные таблиц customer_info.xlsx (информация о клиентах) и transactions_info.xlsx 
#(информация о транзакциях за период с 01.06.2015 по 01.06.2016), нужно вывести:
#список клиентов с непрерывной историей за год, то есть каждый месяц на регулярной основе без пропусков за 
#указанный годовой период, средний чек за период с 01.06.2015 по 01.06.2016, средняя сумма покупок за месяц, 
#количество всех операций по клиенту за период;информацию в разрезе месяцев:

use customers_transaction;
select * from customers;
select * from transactions;

SELECT
    t.ID_client,
    c.Gender,
    c.age,
    c.Count_city,
    ROUND(SUM(t.Sum_payment) / COUNT(DISTINCT t.Id_check), 2) AS avg_check,
    ROUND(SUM(t.Sum_payment) / 12, 2) AS avg_monthly_purchase,
    COUNT(DISTINCT t.Id_check) AS total_operations
FROM transactions AS t
JOIN customers AS c
    ON t.ID_client = c.Id_client
WHERE t.date_new >= '2015-06-01'
  AND t.date_new < '2016-06-01'
GROUP BY
    t.ID_client,
    c.Gender,
    c.age,
    c.Count_city
HAVING COUNT(DISTINCT DATE_FORMAT(t.date_new, '%Y-%m')) = 12
ORDER BY t.ID_client;



#средняя сумма чека в месяц;

SELECT
    DATE_FORMAT(t.date_new, '%Y-%m') AS month,
    ROUND(
        SUM(t.Sum_payment) / COUNT(DISTINCT t.Id_check),
        2
    ) AS avg_check
FROM transactions AS t
WHERE t.date_new >= '2015-06-01'
  AND t.date_new < '2016-06-01'
GROUP BY DATE_FORMAT(t.date_new, '%Y-%m')
ORDER BY month;


#среднее количество операций в месяц;

SELECT
    DATE_FORMAT(t.date_new, '%Y-%m') AS month,
    COUNT(DISTINCT t.Id_check) AS operations
FROM transactions AS t
WHERE t.date_new >= '2015-06-01'
  AND t.date_new < '2016-06-01'
GROUP BY DATE_FORMAT(t.date_new, '%Y-%m')
ORDER BY month;

#среднее количество клиентов, которые совершали операции;
SELECT
    DATE_FORMAT(t.date_new, '%Y-%m') AS month,
    COUNT(DISTINCT t.ID_client) AS clients
FROM transactions AS t
WHERE t.date_new >= '2015-06-01'
  AND t.date_new < '2016-06-01'
GROUP BY DATE_FORMAT(t.date_new, '%Y-%m')
ORDER BY month;

#долю от общего количества операций за год и долю в месяц от общей суммы операций;
SELECT
    DATE_FORMAT(date_new, '%Y-%m') AS month,

    COUNT(DISTINCT Id_check) AS operations,

    ROUND(
        COUNT(DISTINCT Id_check) * 100.0 /
        SUM(COUNT(DISTINCT Id_check)) OVER (),
        2
    ) AS operations_share,

    SUM(Sum_payment) AS total_amount,

    ROUND(
        SUM(Sum_payment) * 100.0 /
        SUM(SUM(Sum_payment)) OVER (),
        2
    ) AS amount_share

FROM transactions 

WHERE date_new >= '2015-06-01'
  AND date_new < '2016-06-01'

GROUP BY DATE_FORMAT(date_new, '%Y-%m')

ORDER BY month;

#вывести % соотношение M/F/NA в каждом месяце с их долей затрат;
SELECT
    DATE_FORMAT(t.date_new, '%Y-%m') AS month,

    c.Gender,

    COUNT(DISTINCT t.ID_client) AS clients,

    ROUND(
        COUNT(DISTINCT t.ID_client) * 100.0 /
        SUM(COUNT(DISTINCT t.ID_client)) OVER (
            PARTITION BY DATE_FORMAT(t.date_new, '%Y-%m')
        ),
        2
    ) AS gender_share,

    SUM(t.Sum_payment) AS total_spending,

    ROUND(
        SUM(t.Sum_payment) * 100.0 /
        SUM(SUM(t.Sum_payment)) OVER (
            PARTITION BY DATE_FORMAT(t.date_new, '%Y-%m')
        ),
        2
    ) AS spending_share

FROM transactions AS t

JOIN customers AS c
    ON t.ID_client = c.Id_client

WHERE t.date_new >= '2015-06-01'
  AND t.date_new < '2016-06-01'

GROUP BY
    DATE_FORMAT(t.date_new, '%Y-%m'),
    c.Gender

ORDER BY
    month,
    c.Gender;


#возрастные группы клиентов с шагом 10 лет и отдельно клиентов, у которых нет данной информации, с параметрами сумма и количество операций за весь период, и поквартально - средние показатели и %.
SELECT
    CASE
        WHEN c.age IS NULL THEN 'NA'
        ELSE CONCAT(
            FLOOR(c.age / 10) * 10,
            '-',
            FLOOR(c.age / 10) * 10 + 9
        )
    END AS age_group,

    SUM(t.Sum_payment) AS total_amount,

    COUNT(DISTINCT t.Id_check) AS total_operations

FROM transactions AS t

JOIN customers AS c
    ON t.ID_client = c.Id_client

WHERE t.date_new >= '2015-06-01'
  AND t.date_new < '2016-06-01'

GROUP BY age_group

ORDER BY age_group;

#Поквартально: средние показатели и %
SELECT
    quarter,
    age_group,

    COUNT(DISTINCT ID_client) AS clients,

    COUNT(DISTINCT Id_check) AS operations,

    SUM(Sum_payment) AS total_amount,

    ROUND(
        SUM(Sum_payment) / COUNT(DISTINCT Id_check),
        2
    ) AS avg_check,

    ROUND(
        COUNT(DISTINCT Id_check) / COUNT(DISTINCT ID_client),
        2
    ) AS avg_operations_per_client,

    ROUND(
        COUNT(DISTINCT Id_check) * 100.0 /
        SUM(COUNT(DISTINCT Id_check)) OVER (
            PARTITION BY quarter
        ),
        2
    ) AS operations_share,

    ROUND(
        SUM(Sum_payment) * 100.0 /
        SUM(SUM(Sum_payment)) OVER (
            PARTITION BY quarter
        ),
        2
    ) AS amount_share

FROM (
    SELECT
        t.ID_client,
        t.Id_check,
        t.Sum_payment,
        t.date_new,

        CONCAT(
            YEAR(t.date_new),
            '-Q',
            QUARTER(t.date_new)
        ) AS quarter,

        CASE
            WHEN c.age IS NULL THEN 'NA'
            ELSE CONCAT(
                FLOOR(c.age / 10) * 10,
                '-',
                FLOOR(c.age / 10) * 10 + 9
            )
        END AS age_group

    FROM transactions AS t

    JOIN customers AS c
        ON t.ID_client = c.Id_client

    WHERE t.date_new >= '2015-06-01'
      AND t.date_new < '2016-06-01'
) AS data

GROUP BY
    quarter,
    age_group

ORDER BY
    quarter,
    age_group;