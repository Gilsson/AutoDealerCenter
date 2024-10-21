-- Table: basket_items
CREATE TABLE IF NOT EXISTS basket_items
(
    id SERIAL PRIMARY KEY,
    car_id integer NOT NULL REFERENCES cars (id) ON DELETE CASCADE,
    basket_id integer NOT NULL REFERENCES baskets (id) ON DELETE CASCADE,
    amount integer NOT NULL DEFAULT 1 CHECK (amount > 0),
);

-- Table: baskets
CREATE TABLE baskets
(
    id SERIAL PRIMARY KEY,
    user_id integer NOT NULL UNIQUE REFERENCES users (id) ON DELETE CASCADE
);

-- Table: brands
CREATE TABLE brands
(
    id SERIAL PRIMARY KEY,
    brand_name character varying(50) NOT NULL UNIQUE
);

-- Table: cars
CREATE TABLE cars
(
    id SERIAL PRIMARY KEY,
    model_id integer REFERENCES models (id) ON DELETE NO ACTION,
    price numeric(19,2) NOT NULL CHECK(price > 0),
    year integer NOT NULL CHECK(year > 1885)
);

-- Table: coupon_types
CREATE TABLE coupon_types
(
    id SERIAL PRIMARY KEY,
    coupon_id integer NOT NULL REFERENCES coupons (id) ON DELETE CASCADE,
    car_id integer NOT NULL REFERENCES cars (id) ON DELETE CASCADE,
    CONSTRAINT coupon_types_pkey PRIMARY KEY (id)
);

-- Table: coupons
CREATE TABLE coupons
(
    id SERIAL PRIMARY KEY,
    code character varying(20) NOT NULL UNIQUE CHECK(length(code) > 0),
    discount_percentage numeric(5,2) NOT NULL CHECK (discount_percentage <= 100 AND discount_percentage > 0),
    expiration_date TIMESTAMPTZ NOT NULL CHECK (expiration_date > now())
);

-- Table: images
CREATE TABLE images
(
    id SERIAL PRIMARY KEY,
    car_id integer REFERENCES cars (id) ON DELETE CASCADE,
    image_url character varying(30) NOT NULL,
    description character varying(30)
);

-- Table: logs
CREATE TABLE logs
(
    id SERIAL PRIMARY KEY,
    user_id integer NOT NULL REFERENCES users (id) ON DELETE NO ACTION,
    action character varying(30),
    "timestamp" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table: models
CREATE TABLE models
(
    id SERIAL PRIMARY KEY,
    model_name character varying(100) NOT NULL,
    brand_id integer REFERENCES brands (id) ON DELETE NO ACTION
);

-- Table: order_items
CREATE TABLE order_items
(
    id SERIAL PRIMARY KEY,
    car_id integer NOT NULL REFERENCES cars (id) ON DELETE NO ACTION,
    order_id integer NOT NULL REFERENCES orders (id) ON DELETE CASCADE,
    amount integer NOT NULL DEFAULT 1,
    CONSTRAINT order_amount_not_zero CHECK (amount > 0)
);

-- Table: orders
CREATE TABLE orders
(
    id SERIAL PRIMARY KEY,
    user_id integer NOT NULL REFERENCES users (id) ON DELETE NO ACTION,
    order_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    price numeric(19,2) NOT NULL CHECK (price > 0),
);

-- Table: payments
CREATE TABLE payments
(
    id SERIAL PRIMARY KEY,
    order_id integer NOT NULL REFERENCES orders (id) ON DELETE CASCADE,
    payment_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_method character varying(20) NOT NULL,
    amount numeric(19,2) NOT NULL CHECK (amount > 0),
    status character varying(9) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'failed'))
);

-- Table: reviews
CREATE TABLE reviews
(
    id SERIAL PRIMARY KEY,
    car_id integer NOT NULL REFERENCES cars (id) ON DELETE NO ACTION,
    user_id integer NOT NULL REFERENCES users (id) ON DELETE NO ACTION,
    rating integer NOT NULL DEFAULT 3 CHECK (rating IN (1, 2, 3, 4, 5)),
    comment text
);

-- Table: roles
CREATE TABLE roles
(
    id SERIAL PRIMARY KEY,
    role_name character varying(30) NOT NULL DEFAULT 'user' UNIQUE
);

-- Table: users
CREATE TABLE users
(
    id SERIAL PRIMARY KEY,
    first_name character varying(64) NOT NULL,
    last_name character varying(64) NOT NULL,
    email character varying(64) NOT NULL UNIQUE,
    password_hash character varying(100) NOT NULL UNIQUE,
    role_id integer NOT NULL REFERENCES roles (id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);