create database e_auction;
use e_auction;
create table register(
id int primary key auto_increment,
email varchar(30) unique,
user_name varchar(20)  not null,
phone_number varchar(11),
password varchar(20)
);
select * from register;
insert into register(email,user_name,phone_number,password) values("admin@bidderboy.com","Bidderboy","7890654321","Bidderboy@123");
create table seller(
id int ,
seller_name varchar(20),
product_id int primary key auto_increment,
product_caterogy varchar(30),
product_name varchar(40),
image longblob,
product_model varchar(40),
product_condition varchar(20),
product_description varchar(400),
terms_and_conditions varchar(400),
bid_start_amount int,
bid_start_date date,
bid_end_date date,
iso_certification LONGBLOB,
is_approval boolean default false,
constraint fk_id foreign key(id) references register(id)
);
select * from seller order by bid_end_date asc;
alter table seller add column is_deleted boolean default false;
create table bidder(
id int primary key auto_increment, 
bidder_id int,
bidder_name varchar(20)  not null,
product_name varchar(20),
bid_amount int,
constraint fk_bidder foreign key (bidder_id) references register(id)
);
select * from bidder;
alter table bidder drop constraint fk_bidder ;
drop table bidder;
truncate table bidder;
drop table bidder;
alter table bidder modify column bidder_name varchar(20) not null;
select bidder_name, product_name, max(bid_amount) as bid_amount from bidder where product_name = ? group by product_name, bidder_name limit 1;
create table transaction(
transaction_id int primary key auto_increment,
bidder_id int,
bidder_name varchar(20) not null,
product_name varchar(20),
payable_amount int(20),
paid_status boolean default false,
constraint fk_bidder_id foreign key(bidder_id) references register(id)
);

select * from transaction;

insert into transaction(bidder_id,bidder_name,product_name,payable_amount,paid_status) values(1,"Chandhuru","Royal Enfield ",170000,0);
