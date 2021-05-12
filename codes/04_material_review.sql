create database review

use review

create table customers (
  -- Columns
  customer_id char(5),
  customer_favourite_number int identity(1, 1), -- start 1, increment 1
  customer_name varchar(30) unique,
  customer_age int not null,
  customer_location varchar(30) default 'Jakarta',

  -- Keys
  constraint PK_customers
    primary key(customer_id),

  -- Constraints
  constraint customersCheckID
    check(customer_id like 'CS[0-9][0-9][0-9]'),
  constraint customersCheckAge
    check(customer_age between 10 and 30),
  constraint customersCheckName
    check(len(customer_name) > 5)
)

-- Insert Row
insert into 
  customers(customer_id, customer_name, customer_age)
values('CS001', 'Budianto', 20)

create table transactionsDetails (
  -- Columns
  transactionsDetails_id char(5),
  transactionsDetails_name varchar(30),
  transactionsDetails_price bigint,

  -- Keys
  constraint PK_transactionsDetails
    primary key(transactionsDetails_id),

  -- Constraints
  constraint transactionsDetailsCheckID
    check(transactionsDetails_id like 'TD[0-9][0-9][0-9]')
)

create table transactions (
  -- Columns
  transactions_customer_id char(5),
  transactions_transactionsDetails_id char(5),

  -- Keys

  -- Composite Key
  constraint CK_transactions
    primary key(transactions_customer_id, transactions_transactionsDetails_id),

  -- Foreign Keys
  constraint FK_customer_id
    foreign key(transactions_transactionsDetails_id)
    references customers(customer_id)
    on update cascade
    on delete cascade,

  constraint FK_transactionsDetails_id
    foreign key(transactions_transactionsDetails_id)
    references transactionsDetails(transactionsDetails_id)
    on update cascade
    on delete cascade,

  -- Constraints
  constraint transactionsCheckCustomerID
    check(transactions_customer_id like 'CS[0-9][0-9][0-9]'),
  constraint transactionsCheckTransactionsDetails_id
    check(transactions_transactionsDetails_id like 'TD[0-9][0-9][0-9]')  
)

-- Insert
insert into
  transactionsDetails
VALUES 
  ('TD001', 'Uang Lab', 15000),
  ('TD002', 'Uang Gedung', 12000),
  ('TD003', 'Textbook', 12000),
  ('TD004', 'Uang Sumbangan', 11500),
  ('TD005', 'Uang Semester', 13500)

-- Update
update transactionsDetails
  set transactionsDetails_price = 0
  where transactionsDetails_id = 'TD002'

-- Remove
delete
  from transactionsDetails
  where transactionsDetails_name = 'Uang Semester'

-- Begin tran, commit, rollback
begin tran
  update transactionsDetails
  set transactionsDetails_price = 10
  where transactionsDetails_name = 'Textbook'
commit -- udah bener
rollback -- ada kesalahan

-- Replace substring (ini bukan update)
select 
  transactionsDetails_id = replace(transactionsDetails_id, 'TD', 'TR')
from transactionsDetails

-- VIEW DATABASES

--  Select statements
select * from customers
select * from transactionsDetails
select * from transactions

-- Remove Rows
delete from customers
delete from transactions
delete from transactionsDetails

-- Remove Tables
drop table customers
drop table transactions
drop table transactionsDetails