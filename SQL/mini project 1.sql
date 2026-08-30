-- Напишите запрос SQL, выводящий одним числом количество уникальных пользователей в этой таблице в период с 2023-11-07 по 2023-11-15.

select distinct count(*)
from users
where date between '2023-11-07' and '2023-11-15';

-- Определите пользователя, который за весь период посмотрел наибольшее количество объявлений. 
select user_id, max(view_adverts)
from users 
group by user_id
order by view_adverts desc
limit 1;

-- Определите день с наибольшим средним количеством просмотренных рекламных объявлений на пользователя, 
-- но учитывайте только дни с более чем 500 уникальными пользователями.

use miniproject1;
select date, avg(view_adverts) as avg_views
from users 
group by date
having count(distinct user_id)>500
order by avg_views desc
limit 1;

-- Напишите запрос возвращающий LT (продолжительность присутствия пользователя на сайте) 
-- по каждому пользователю. Отсортировать LT по убыванию.

SELECT user_id, COUNT(DISTINCT date) AS active_days
FROM users
GROUP BY user_id
ORDER BY active_days DESC;


-- Для каждого пользователя подсчитайте среднее количество просмотренной рекламы за день, а затем выясните, 
-- у кого самый высокий средний показатель среди тех, кто был активен как минимум в 5 разных дней.
 select user_id, count(distinct date) as active_days, avg(view_adverts) as avg_views
 from users 
 group by user_id
 having COUNT(DISTINCT date)>=5
 order by avg_views desc
 limit 1;



