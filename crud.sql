--users

DELETE FROM users WHERE id = $1;
UPDATE users SET first_name = $1, last_name = $2, email = $3, password_hash = $4, role_id = $5 WHERE id = $6 RETURNING *;
INSERT INTO users (first_name, last_name, email, password_hash, role_id) VALUES ($1, $2, $3, crypt($4, gen_salt(\'des\')), $5) RETURNING *;
SELECT id, first_name, last_name, email, password_hash, role_id, created_at FROM users WHERE password_hash = crypt($1, password_hash);

--roles

SELECT id, role_name FROM roles;
INSERT INTO roles (role_name) VALUES ($1) RETURNING *;
UPDATE users SET role_name = $1, WHERE id = $2 RETURNING *;
DELETE FROM roles WHERE id = $1;

--cars

SELECT id, model_id, price, year FROM cars;
INSERT INTO cars (model_id, price, year) VALUES ($1, $2, $3) RETURNING *;
UPDATE cars SET model_id = $1, price = $2, year = $3 WHERE id = $4;
DELETE FROM cars WHERE id = $1;

--basket

SELECT id, user_id FROM baskets;
INSERT INTO baskets (user_id) VALUES ($1) RETURNING *;
UPDATE baskets SET user_id = $1 WHERE id = $2 RETURNING *;
DELETE FROM baskets WHERE id = $1;
UPDATE basket_items SET amount = $1 WHERE basket_id = $2 AND car_id = $3;
INSERT INTO basket_items (car_id, basket_id, amount) VALUES ($1, $2) RETURNING *;
SELECT id, car_id, basket_id, amount FROM basket_items WHERE basket_id = $1;
UPDATE basket_items SET car_id = $1, basket_id = $2, amount = $3 WHERE id = $4;
DELETE FROM basket_items WHERE id = $1;