# Correlated Subquery Practice

### 1. Employees above their department average ⭐⭐⭐

Find employees whose salary is **greater than the average salary of their own department**.

**Output:**

* `employee_name`
* `department_name`
* `salary`

---

### 2. Employees with the second-highest salary in their department ⭐⭐⭐⭐

Find employees who have the **second-highest distinct salary within their department**.

**Output:**

* `employee_name`
* `department_name`
* `salary`

---

### 3. Customers with an order above their own average order value ⭐⭐⭐⭐

Find customers who have placed **at least one order whose total value is greater than that customer's own average order value**.

Remember that an order's value is:

```text
quantity × product price
```

**Output:**

* `customer_name`
* `order_id`
* `order_value`

---

### 4. Products selling more than other products in their category ⭐⭐⭐⭐

Find products whose **total quantity sold is greater than at least one other product's total quantity sold within the same category**.

**Output:**

* `product_name`
* `category`
* `total_quantity_sold`

---

### 5. Customers whose latest order is their highest-value order ⭐⭐⭐⭐⭐

Find customers whose **most recent order is also their highest-value order**.

**Output:**

* `customer_name`
* `order_id`
* `order_date`
* `order_value`

---

### 6. Customers whose every order is above a threshold based on their own history ⭐⭐⭐⭐⭐

Find customers for whom **every order they've placed is greater than the average order value of all their orders**.

In other words, for each customer:

```text
Every order value > that customer's average order value
```

**Output:**

* `customer_name`
* `average_order_value`

---

## Recommended Order

Solve them in this order:

```text
1 → Department average
      ↓
2 → Department ranking
      ↓
3 → Customer's own average
      ↓
4 → Product/category comparison
      ↓
5 → Latest vs highest
      ↓
6 → Every order vs customer's average
```

**Don't use CTEs or window functions initially.** Try solving these specifically with **correlated subqueries**, because the goal is to strengthen your understanding of how the inner query refers back to the outer query.
