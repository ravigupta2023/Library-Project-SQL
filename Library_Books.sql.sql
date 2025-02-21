create table books
(isbn varchar(20) primary key,
book_title varchar(60),
category varchar(20),
rental_price float,
status varchar(10),
author varchar(30),
publisher varchar(30)
)

create table branch 
(
branch_id varchar(10) primary key,
manager_id	varchar(10),
branch_address varchar(30),
contact_no varchar(20)
)

create table employee
(
emp_id varchar(10) primary key,
emp_name varchar(40),
position varchar(20),
salary money,
branch_id varchar (10)

)
create table issue_status
(
issued_id varchar(10) primary key,
issued_member_id varchar(10),
issued_book_name varchar(60),
issued_date date,
issued_book_isbn varchar(20),
issued_emp_id varchar(10)
)
create table members
(
member_id varchar(10) primary key,
member_name	varchar(30),
member_address varchar(30),
reg_date date

)
create table return_status
(
return_id varchar(10) primary key,
issued_id varchar(10),
return_book_name varchar(10),
return_date date,
return_book_isbn varchar(10)

)

-- defining foreign key
alter table issue_status
add constraint isbn_fkey 
foreign key(issued_book_isbn)
references books(isbn)

alter table employee
add constraint branch_id_fkey 
foreign key(branch_id)
references branch(branch_id)

alter table issue_status
add constraint emp_id_fkey 
foreign key(issued_emp_id)
references employee(emp_id)

alter table return_status
add constraint issued_id_fkey 
foreign key(issued_id)
references issue_status(issued_id)


alter table issue_status
add constraint issued_mem_id_fkey 
foreign key(issued_member_id)
references members(member_id)

-- foreign key defining done here
-- working on problems
 
 /*Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
*/
insert into books(isbn,book_title, category, rental_price, status, author, publisher)
values('978-1-60129-456-2','To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')

-- Task 2: Update an Existing Member's Address

update members
set member_address = '786 hill road'
where member_id = 'C101'
select * from members


-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS104' 
-- from the issued_status table.

delete from issue_status
where issued_id = 'IS104'

select * from issue_status
where issued_id = 'IS104'



-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee 
--with emp_id = 'E101'.

select * from employee
where emp_id = 'E101'

-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have
--issued more than one book.

select m.member_name,count(issued_book_name) as total_books 
from members as m
join 
issue_status as s
on m.member_id = s.issued_member_id
group by 1
having count(issued_book_name)>1

select * from issue_status



-- ### 3. CTAS (Create Table As Select)

-- Task 6: Create Summary Tables**: Used CTAS to generate 
--0new tables based on query results - each book and 
--total book_issued_cnt


-- ### 4. Data Analysis & Findings

-- Task 7. **Retrieve All Books in a Specific Category:
select * from books
select category, count(book_title)
from books
group by 1

-- Task 8: Find Total Rental Income by Category:

select * from books
select category, sum(rental_price)
from books
group by category


-- Task 9. **List Members Who Registered in the Last 180 Days**:

select * from members 
select member_name, extract(month from reg_date)as days
from members
where extract(month from reg_date)<06

-- Task 10: List Employees with Their Branch Manager's Name
--and their branch details**:

select * from branch
select * from employee

select e.emp_id, e.emp_name, b.manager_id
from branch as b
join 
employee as e
on b.branch_id = e.branch_id


