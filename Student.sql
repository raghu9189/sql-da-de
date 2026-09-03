create database test;

use test;

-- Student Table
CREATE TABLE
    student (
        roll_no INT PRIMARY KEY,
        name VARCHAR(50),
        secured_marks INT,
        max_marks INT
    );

INSERT INTO
    student (roll_no, name, secured_marks, max_marks)
VALUES
    (101, 'Rahul', 85, 100),
    (102, 'Priya', 92, 100),
    (103, 'Arjun', 76, 100),
    (104, 'Sneha', 68, 100),
    (105, 'Kiran', 88, 100),
    (106, 'Anjali', 95, 100),
    (107, 'Vikram', 72, 100),
    (108, 'Divya', 81, 100),
    (109, 'Rohit', 59, 100),
    (110, 'Meena', 90, 100);

-- same marks insert
INSERT INTO
    student (roll_no, name, secured_marks, max_marks)
VALUES
    (111, 'Eshwar', 85, 100),
    (112, 'Madhuri', 85, 100);

-- Fetch student table
select
    *
from
    student;

select
    name,
    round(secured_marks / max_marks * 100) as Percentage,
    dense_rank() over (
        order by
            secured_marks desc
    ) as DenseRank,
    rank() over (
        order by
            secured_marks desc
    ) as ClassicRank,
    row_number() over (
        order by
            secured_marks desc
    ) index_no,
    case
        when secured_marks >= 85 then 'Excellent'
        when secured_marks > 75 then 'Very Good'
        when secured_marks > 50 then 'Good'
        when secured_marks > 35 then 'OK'
    end 'Remarks'
from
    student;

select
    roll_no,
    name,
    secured_marks,
    lead (secured_marks) over () ld,
    lag (secured_marks) over () lg
from
    student;

select
    length (name)
from
    student;

SELECT
    NOW () AS current_datetime;

SELECT
    CURDATE () AS current_date;

SELECT
    CURTIME () AS current_time;

select
    name,
    left (name, 3),
    substr (name, length (name), 1)
from
    student;

-- find duplicates using group by and having
select
    name,
    count(name)
from
    student
group by
    name
having
    count(name) > 1;

-- find duplicates using window function
select
    roll_no,
    name,
    row_number() over (
        partition by
            name
        order by
            name
    ) as rowNum
from
    student;

-- Fetch all employees whose names contain the letter “a” exactly twice.
select
    *
from
    student
where
    name like "%a%a%"
    and name not like "%a%a%a%";