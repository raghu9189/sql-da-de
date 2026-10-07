import random
import math
from datetime import datetime, date, timedelta

# ============================================================
# CONFIGURATION
# ============================================================

START_DATE = date(2016, 1, 1)
END_DATE = date(2025, 12, 31)

NUM_CUSTOMERS = 10000
NUM_PRODUCTS = 500

# Average transactions per day.
# 50 gives ~182K transactions over 10 years.
# Increase to 100/200 if you want a much larger dataset.
AVG_ORDERS_PER_DAY = 60

OUTPUT_FILE = "sql_date_time_interview_dataset.sql"

random.seed(42)


# ============================================================
# HELPER FUNCTIONS
# ============================================================

def sql_escape(value):
    """Escape strings for MySQL."""
    if value is None:
        return "NULL"

    value = str(value)
    value = value.replace("\\", "\\\\")
    value = value.replace("'", "''")

    return f"'{value}'"


def random_datetime(start_dt, end_dt):
    """Generate random datetime between two datetimes."""
    seconds = int((end_dt - start_dt).total_seconds())

    return start_dt + timedelta(
        seconds=random.randint(0, seconds)
    )


def random_time_for_business():
    """
    Generate realistic transaction time.

    More transactions during:
    10 AM - 1 PM
    5 PM - 10 PM
    """

    periods = [
        (0, 6, 5),
        (6, 10, 10),
        (10, 14, 25),
        (14, 17, 15),
        (17, 22, 35),
        (22, 24, 10),
    ]

    hours = []

    for start, end, weight in periods:
        for _ in range(weight):
            hours.append(
                random.randint(start, end - 1)
            )

    hour = random.choice(hours)
    minute = random.randint(0, 59)
    second = random.randint(0, 59)

    return hour, minute, second


def mysql_datetime(dt):
    return dt.strftime("%Y-%m-%d %H:%M:%S")


def mysql_date(d):
    return d.strftime("%Y-%m-%d")


def random_choice_weighted(items):
    """
    items = [(value, weight), ...]
    """

    values = [x[0] for x in items]
    weights = [x[1] for x in items]

    return random.choices(values, weights=weights, k=1)[0]


# ============================================================
# STATIC DATA
# ============================================================

FIRST_NAMES = [
    "Rahul", "Amit", "Ravi", "Arjun", "Kiran",
    "Suresh", "Vijay", "Raj", "Anil", "Manoj",
    "Priya", "Sneha", "Anjali", "Pooja", "Divya",
    "Neha", "Swathi", "Kavya", "Meena", "Lakshmi",
    "John", "David", "Michael", "Daniel", "Robert",
    "Emily", "Sarah", "Emma", "Sophia", "Olivia"
]

LAST_NAMES = [
    "Kumar", "Sharma", "Reddy", "Patel", "Rao",
    "Singh", "Verma", "Gupta", "Mehta", "Joshi",
    "Williams", "Brown", "Smith", "Johnson", "Davis"
]

CITIES = [
    ("Hyderabad", "Telangana"),
    ("Karimnagar", "Telangana"),
    ("Warangal", "Telangana"),
    ("Bangalore", "Karnataka"),
    ("Chennai", "Tamil Nadu"),
    ("Mumbai", "Maharashtra"),
    ("Pune", "Maharashtra"),
    ("Delhi", "Delhi"),
    ("Kolkata", "West Bengal"),
    ("Ahmedabad", "Gujarat"),
    ("Jaipur", "Rajasthan"),
    ("Lucknow", "Uttar Pradesh"),
    ("Vijayawada", "Andhra Pradesh"),
    ("Visakhapatnam", "Andhra Pradesh"),
    ("Kochi", "Kerala"),
]

CATEGORIES = [
    "Electronics",
    "Furniture",
    "Clothing",
    "Books",
    "Home & Kitchen",
    "Beauty",
    "Sports",
    "Grocery",
    "Toys",
    "Accessories"
]

PRODUCT_NAMES = {
    "Electronics": [
        "Laptop", "Smartphone", "Tablet", "Monitor",
        "Keyboard", "Mouse", "Headphones", "Smart Watch",
        "Bluetooth Speaker", "Power Bank"
    ],

    "Furniture": [
        "Office Chair", "Study Table", "Bookshelf",
        "Sofa", "Dining Table", "Bed", "Wardrobe"
    ],

    "Clothing": [
        "T-Shirt", "Jeans", "Shirt", "Jacket",
        "Dress", "Kurta", "Saree", "Shoes"
    ],

    "Books": [
        "SQL Fundamentals", "Python Programming",
        "Data Science", "Machine Learning",
        "Statistics", "Database Systems",
        "Business Analytics"
    ],

    "Home & Kitchen": [
        "Mixer", "Cooker", "Microwave",
        "Water Bottle", "Coffee Maker", "Air Fryer"
    ],

    "Beauty": [
        "Face Wash", "Shampoo", "Moisturizer",
        "Perfume", "Sunscreen"
    ],

    "Sports": [
        "Cricket Bat", "Football", "Badminton Racket",
        "Yoga Mat", "Running Shoes"
    ],

    "Grocery": [
        "Rice", "Oil", "Sugar", "Coffee",
        "Tea", "Flour", "Dal"
    ],

    "Toys": [
        "Remote Car", "Puzzle", "Board Game",
        "Action Figure", "Building Blocks"
    ],

    "Accessories": [
        "Wallet", "Backpack", "Belt",
        "Sunglasses", "Watch"
    ]
}


# ============================================================
# CREATE SQL FILE
# ============================================================

with open(OUTPUT_FILE, "w", encoding="utf-8") as f:

    # ========================================================
    # DATABASE
    # ========================================================

    f.write("""
DROP DATABASE IF EXISTS sql_interview_practice;

CREATE DATABASE sql_interview_practice;

USE sql_interview_practice;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

SET FOREIGN_KEY_CHECKS = 1;
""")


    # ========================================================
    # CUSTOMERS
    # ========================================================

    f.write("""
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(150),
    city VARCHAR(100),
    state VARCHAR(100),
    signup_date DATE,
    birth_date DATE,
    gender VARCHAR(20),
    customer_segment VARCHAR(30)
);

""")


    # ========================================================
    # PRODUCTS
    # ========================================================

    f.write("""
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(100),
    price DECIMAL(10,2),
    launch_date DATE
);

""")


    # ========================================================
    # ORDERS
    # ========================================================

    f.write("""
CREATE TABLE orders (
    order_id BIGINT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_datetime DATETIME,
    payment_datetime DATETIME,
    delivery_datetime DATETIME NULL,
    return_datetime DATETIME NULL,
    order_status VARCHAR(30),
    payment_status VARCHAR(30),
    shipping_method VARCHAR(30),
    total_amount DECIMAL(12,2),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

""")


    # ========================================================
    # ORDER ITEMS
    # ========================================================

    f.write("""
CREATE TABLE order_items (
    order_item_id BIGINT PRIMARY KEY,
    order_id BIGINT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_percent DECIMAL(5,2),
    line_total DECIMAL(12,2),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

""")


    # ========================================================
    # INDEXES
    # ========================================================

    f.write("""
CREATE INDEX idx_orders_customer
ON orders(customer_id);

CREATE INDEX idx_orders_date
ON orders(order_date);

CREATE INDEX idx_orders_datetime
ON orders(order_datetime);

CREATE INDEX idx_orders_status
ON orders(order_status);

CREATE INDEX idx_orders_payment_datetime
ON orders(payment_datetime);

CREATE INDEX idx_orders_delivery_datetime
ON orders(delivery_datetime);

CREATE INDEX idx_orders_return_datetime
ON orders(return_datetime);

CREATE INDEX idx_order_items_product
ON order_items(product_id);

""")


    # ========================================================
    # CUSTOMERS DATA
    # ========================================================

    print("Generating customers...")

    customer_rows = []

    for customer_id in range(1, NUM_CUSTOMERS + 1):

        first_name = random.choice(FIRST_NAMES)
        last_name = random.choice(LAST_NAMES)

        city, state = random.choice(CITIES)

        signup_start = date(2015, 1, 1)
        signup_end = date(2025, 12, 1)

        signup_date = signup_start + timedelta(
            days=random.randint(
                0,
                (signup_end - signup_start).days
            )
        )

        birth_year = random.randint(1965, 2002)

        birth_date = date(
            birth_year,
            random.randint(1, 12),
            random.randint(1, 28)
        )

        gender = random_choice_weighted([
            ("Male", 50),
            ("Female", 45),
            ("Other", 5)
        ])

        segment = random_choice_weighted([
            ("New", 20),
            ("Regular", 50),
            ("Premium", 20),
            ("VIP", 10)
        ])

        email = (
            f"{first_name.lower()}."
            f"{last_name.lower()}."
            f"{customer_id}"
            f"@example.com"
        )

        customer_rows.append(
            f"""(
                {customer_id},
                {sql_escape(first_name)},
                {sql_escape(last_name)},
                {sql_escape(email)},
                {sql_escape(city)},
                {sql_escape(state)},
                '{mysql_date(signup_date)}',
                '{mysql_date(birth_date)}',
                {sql_escape(gender)},
                {sql_escape(segment)}
            )"""
        )

        if len(customer_rows) >= 1000:

            f.write(
                "INSERT INTO customers VALUES\n"
            )

            f.write(
                ",\n".join(customer_rows)
            )

            f.write(";\n\n")

            customer_rows = []

    if customer_rows:

        f.write(
            "INSERT INTO customers VALUES\n"
        )

        f.write(
            ",\n".join(customer_rows)
        )

        f.write(";\n\n")


    # ========================================================
    # PRODUCTS DATA
    # ========================================================

    print("Generating products...")

    product_rows = []

    for product_id in range(1, NUM_PRODUCTS + 1):

        category = random.choice(CATEGORIES)

        product_name = random.choice(
            PRODUCT_NAMES[category]
        )

        product_name = (
            f"{product_name} Model "
            f"{random.randint(100,999)}"
        )

        price_ranges = {
            "Electronics": (500, 120000),
            "Furniture": (2000, 80000),
            "Clothing": (300, 10000),
            "Books": (200, 3000),
            "Home & Kitchen": (300, 25000),
            "Beauty": (150, 8000),
            "Sports": (300, 15000),
            "Grocery": (50, 3000),
            "Toys": (200, 10000),
            "Accessories": (200, 12000)
        }

        low, high = price_ranges[category]

        price = round(
            random.uniform(low, high),
            2
        )

        launch_date = (
            date(2015, 1, 1)
            + timedelta(
                days=random.randint(0, 3650)
            )
        )

        product_rows.append(
            f"""(
                {product_id},
                {sql_escape(product_name)},
                {sql_escape(category)},
                {price},
                '{mysql_date(launch_date)}'
            )"""
        )

    f.write(
        "INSERT INTO products VALUES\n"
    )

    f.write(
        ",\n".join(product_rows)
    )

    f.write(";\n\n")


    # ========================================================
    # ORDERS + ORDER ITEMS
    # ========================================================

    print("Generating orders...")

    order_id = 1
    order_item_id = 1

    order_buffer = []
    item_buffer = []

    current_date = START_DATE

    total_orders = 0

    while current_date <= END_DATE:

        # ----------------------------------------------------
        # WEEKEND EFFECT
        # ----------------------------------------------------

        weekday = current_date.weekday()

        if weekday >= 5:
            multiplier = 1.25
        else:
            multiplier = 1.0

        # ----------------------------------------------------
        # SEASONAL EFFECT
        # ----------------------------------------------------

        month = current_date.month

        seasonal_multiplier = 1.0

        if month in [10, 11, 12]:
            seasonal_multiplier = 1.35

        elif month in [6, 7]:
            seasonal_multiplier = 1.15

        elif month in [1, 2]:
            seasonal_multiplier = 0.85

        # ----------------------------------------------------
        # RANDOM DAILY TRANSACTION COUNT
        # ----------------------------------------------------

        mean_orders = (
            AVG_ORDERS_PER_DAY
            * multiplier
            * seasonal_multiplier
        )

        # Approximate Poisson using Gaussian.
        daily_orders = max(
            1,
            int(
                random.gauss(
                    mean_orders,
                    math.sqrt(mean_orders)
                )
            )
        )

        # ----------------------------------------------------
        # CREATE ORDERS
        # ----------------------------------------------------

        for _ in range(daily_orders):

            # -----------------------------------------------
            # ORDER TIME
            # -----------------------------------------------

            hour, minute, second = (
                random_time_for_business()
            )

            order_datetime = datetime(
                current_date.year,
                current_date.month,
                current_date.day,
                hour,
                minute,
                second
            )

            # -----------------------------------------------
            # CUSTOMER
            # -----------------------------------------------

            customer_id = random.randint(
                1,
                NUM_CUSTOMERS
            )

            # -----------------------------------------------
            # ORDER STATUS
            # -----------------------------------------------

            order_status = random_choice_weighted([
                ("Completed", 78),
                ("Shipped", 8),
                ("Processing", 5),
                ("Cancelled", 6),
                ("Returned", 3)
            ])

            # -----------------------------------------------
            # PAYMENT
            # -----------------------------------------------

            if order_status == "Cancelled":

                payment_status = random_choice_weighted([
                    ("Failed", 60),
                    ("Refunded", 40)
                ])

            elif order_status == "Returned":

                payment_status = "Refunded"

            else:

                payment_status = random_choice_weighted([
                    ("Paid", 95),
                    ("Pending", 5)
                ])

            # Payment usually happens shortly after order.

            payment_delay = random.randint(
                1,
                60 * 60 * 6
            )

            payment_datetime = (
                order_datetime
                + timedelta(seconds=payment_delay)
            )

            # -----------------------------------------------
            # SHIPPING METHOD
            # -----------------------------------------------

            shipping_method = random_choice_weighted([
                ("Standard", 55),
                ("Express", 30),
                ("Next Day", 10),
                ("Same Day", 5)
            ])

            # -----------------------------------------------
            # DELIVERY
            # -----------------------------------------------

            delivery_datetime = None

            if order_status in [
                "Completed",
                "Shipped",
                "Returned"
            ]:

                if shipping_method == "Same Day":
                    delivery_days = 0

                elif shipping_method == "Next Day":
                    delivery_days = 1

                elif shipping_method == "Express":
                    delivery_days = random.randint(1, 3)

                else:
                    delivery_days = random.randint(2, 7)

                delivery_datetime = (
                    order_datetime
                    + timedelta(
                        days=delivery_days,
                        hours=random.randint(1, 12)
                    )
                )

            # -----------------------------------------------
            # RETURN
            # -----------------------------------------------

            return_datetime = None

            if order_status == "Returned":

                if delivery_datetime:

                    return_datetime = (
                        delivery_datetime
                        + timedelta(
                            days=random.randint(1, 30),
                            hours=random.randint(1, 12)
                        )
                    )

            # -----------------------------------------------
            # ORDER ITEMS
            # -----------------------------------------------

            number_of_items = random.choices(
                [1, 2, 3, 4, 5],
                weights=[50, 25, 15, 7, 3],
                k=1
            )[0]

            total_amount = 0

            for _ in range(number_of_items):

                product_id = random.randint(
                    1,
                    NUM_PRODUCTS
                )

                quantity = random.choices(
                    [1, 2, 3, 4],
                    weights=[65, 25, 8, 2],
                    k=1
                )[0]

                # Generate a realistic price.
                category = random.choice(
                    CATEGORIES
                )

                low, high = {
                    "Electronics": (500, 120000),
                    "Furniture": (2000, 80000),
                    "Clothing": (300, 10000),
                    "Books": (200, 3000),
                    "Home & Kitchen": (300, 25000),
                    "Beauty": (150, 8000),
                    "Sports": (300, 15000),
                    "Grocery": (50, 3000),
                    "Toys": (200, 10000),
                    "Accessories": (200, 12000)
                }[category]

                unit_price = round(
                    random.uniform(low, high),
                    2
                )

                discount_percent = random.choice([
                    0, 0, 0,
                    5,
                    10,
                    15,
                    20,
                    25
                ])

                line_total = round(
                    quantity
                    * unit_price
                    * (1 - discount_percent / 100),
                    2
                )

                total_amount += line_total

                item_buffer.append(
                    f"""(
                        {order_item_id},
                        {order_id},
                        {product_id},
                        {quantity},
                        {unit_price},
                        {discount_percent},
                        {line_total}
                    )"""
                )

                order_item_id += 1

            total_amount = round(
                total_amount,
                2
            )

            # -----------------------------------------------
            # ORDER ROW
            # -----------------------------------------------

            order_buffer.append(
                f"""(
                    {order_id},
                    {customer_id},
                    '{mysql_date(current_date)}',
                    '{mysql_datetime(order_datetime)}',
                    '{mysql_datetime(payment_datetime)}',
                    {("NULL" if delivery_datetime is None else "'" + mysql_datetime(delivery_datetime) + "'")},
                    {("NULL" if return_datetime is None else "'" + mysql_datetime(return_datetime) + "'")},
                    {sql_escape(order_status)},
                    {sql_escape(payment_status)},
                    {sql_escape(shipping_method)},
                    {total_amount}
                )"""
            )

            order_id += 1
            total_orders += 1

            # -----------------------------------------------
            # WRITE IN BATCHES
            # -----------------------------------------------

            if len(order_buffer) >= 1000:

                f.write(
                    "INSERT INTO orders VALUES\n"
                )

                f.write(
                    ",\n".join(order_buffer)
                )

                f.write(";\n\n")

                order_buffer = []

            if len(item_buffer) >= 3000:

                f.write(
                    "INSERT INTO order_items VALUES\n"
                )

                f.write(
                    ",\n".join(item_buffer)
                )

                f.write(";\n\n")

                item_buffer = []

        # ----------------------------------------------------
        # PROGRESS
        # ----------------------------------------------------

        if current_date.day == 1:

            print(
                current_date,
                "orders:",
                total_orders
            )

        current_date += timedelta(days=1)


    # ========================================================
    # WRITE REMAINING ORDERS
    # ========================================================

    if order_buffer:

        f.write(
            "INSERT INTO orders VALUES\n"
        )

        f.write(
            ",\n".join(order_buffer)
        )

        f.write(";\n\n")


    # ========================================================
    # WRITE REMAINING ITEMS
    # ========================================================

    if item_buffer:

        f.write(
            "INSERT INTO order_items VALUES\n"
        )

        f.write(
            ",\n".join(item_buffer)
        )

        f.write(";\n\n")


    # ========================================================
    # FINAL ANALYSIS INDEXES
    # ========================================================

    f.write("""
ANALYZE TABLE customers;
ANALYZE TABLE products;
ANALYZE TABLE orders;
ANALYZE TABLE order_items;
""")


print()
print("=" * 60)
print("DATA GENERATION COMPLETED")
print("=" * 60)
print(f"SQL file: {OUTPUT_FILE}")
print(f"Approximate orders: {total_orders:,}")
print()
print("Import the generated SQL file into MySQL.")