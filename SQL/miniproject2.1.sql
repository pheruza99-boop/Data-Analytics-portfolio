create database mini_project;
use mini_project;
create table t_tab1
( 
	id int unique,
    goods_type varchar(100) ,
    quantity int ,
    amount int ,
    seller_name varchar(100)
);

insert into t_tab1 (id, goods_type, quantity, amount, seller_name)
values ( 1, 'MOBILE PHONE', 2, 400000, 'MIKE');

insert into t_tab1 (id, goods_type, quantity, amount, seller_name)
values (2, 'KEYBOARD', 1, 10000, 'MIKE'); 
 
insert into t_tab1 (id, goods_type, quantity, amount, seller_name)
values (3, 'MOBILE PHONE', 1, 50000, 'JANE');

insert into t_tab1 (id, goods_type, quantity, amount, seller_name)
values (4, 'MONITOR', 1, 110000, 'JOE');

insert into t_tab1 (id, goods_type, quantity, amount, seller_name)
values (5, 'MONITOR', 2, 80000, 'JANE');

insert into t_tab1 (id, goods_type, quantity, amount, seller_name)
values (6, 'MOBILE PHONE', 1, 130000, 'JOE');

insert into t_tab1 (id, goods_type, quantity, amount, seller_name)
values (7, 'MOBILE PHONE', 1, 60000, 'ANNA');

insert into t_tab1 (id, goods_type, quantity, amount, seller_name)
values (8, 'PRINTER', 1, 90000, 'ANNA');

insert into t_tab1 (id, goods_type, quantity, amount, seller_name)
values (9, 'KEYBOARD', 2, 10000, 'ANNA'); 

insert into t_tab1 (id, goods_type, quantity, amount, seller_name)
values ( 10, 'PRINTER', 1, 80000, 'MIKE'); 

create table t_tab2
(
	id int unique,
    name varchar (100),
    salary int ,
    age int 
    ); 
    
    insert into t_tab2 (id, name, salary, age)
    values (1, 'ANNA', 110000, 27);
   
    insert into t_tab2 (id, name, salary, age)
    values (2, 'JANE', 80000, 25);
    
	insert into t_tab2 (id, name, salary, age)
	values (3, 'MIKE', 120000, 25);
    
	insert into t_tab2 (id, name, salary, age)
	values (4, 'JOE', 70000, 24);
    
	insert into t_tab2 (id, name, salary, age)
	values (5, 'RITA', 120000, 29);



select * from t_tab1;


select * from t_tab2;





