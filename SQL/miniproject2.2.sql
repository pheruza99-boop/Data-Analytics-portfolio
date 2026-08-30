-- Напишите запрос, который вернёт список уникальных категорий товаров (GOODS_TYPE). 
-- Какое количество уникальных категорий товаров вернёт запрос?

select count(distinct goods_type)
from t_tab1;

-- Напишите запрос, который вернет суммарное количество и суммарную стоимость проданных мобильных телефонов. 
-- Какое суммарное количество и суммарную стоимость вернул запрос?

select sum(quantity*amount) as amount, SUM(quantity) as count
from t_tab1 
where goods_type='MOBILE PHONE'; 

-- Напишите запрос, который вернёт список сотрудников с заработной платой > 100000. Какое кол-во сотрудников вернул запрос?
select count(*) from 
t_tab2 
where salary>100000;

-- Напишите запрос, который вернёт минимальный и максимальный возраст сотрудников, а также минимальную и максимальную заработную плату.
select max(age), min(age), max(salary), min(salary)
from t_tab2; 

-- Напишите запрос, который вернёт среднее количество проданных клавиатур и принтеров.
select goods_type, avg (amount*quantity)
from t_tab1
where goods_type in ('MONITOR', 'KEYBOARD')
group by goods_type;


-- Напишите запрос, который вернёт имя сотрудника и суммарную стоимость проданных им товаров.
select seller_name, sum(amount*quantity) as amount
from t_tab1
group by seller_name;


-- Напишите запрос, который вернёт имя сотрудника, тип товара, кол-во товара, 
-- стоимость товара, заработную плату и возраст сотрудника MIKE.
select t2.name, t1.goods_type, t1.quantity, t1.amount, t2.salary, t2.age
from t_tab1 t1 
join t_tab2 t2 
on t2.name=t1.seller_name 
where t2.name= 'MIKE'; 

-- Напишите запрос, который вернёт имя и возраст сотрудника, который ничего не продал. Сколько таких сотрудников?
select count(*) 
from (select t2.name, t2.age 
from t_tab2 t2 
left join t_tab1 t1
on t2.name=t1.seller_name
where t1.seller_name is null) as count;


-- Напишите запрос, который вернёт имя сотрудника и его заработную плату с возрастом меньше 26 лет? Какое количество строк вернул запрос?
select count(*) 
from (select name, salary 
from t_tab2 
where age > 26 ) as count;

-- Сколько строк вернёт следующий запрос:

SELECT count(*)
FROM t_tab1 t
JOIN t_tab2 t2 ON t2.name = t.seller_name
WHERE t2.name = 'RITA';



