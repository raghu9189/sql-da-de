CREATE TABLE
    fruit_sales (
        sale_id INT PRIMARY KEY,
        sale_date DATE,
        amount DECIMAL(10, 2)
    );

INSERT INTO
    fruit_sales (sale_id, sale_date, amount)
VALUES
    (1, '2026-01-01', 1000.00),
    (2, '2026-01-02', 1500.00),
    (3, '2026-01-03', 800.00),
    (4, '2026-01-04', 1200.00),
    (5, '2026-01-05', 2000.00),
    (6, '2026-01-06', 500.00),
    (7, '2026-01-07', 1800.00);

--  Write a query to calculate the running total of sales by date.
select
    sale_date,
    amount,
    sum(amount) over (
        order by
            sale_date
    ) as running_total
from
    fruit_sales
order by
    sale_date;

