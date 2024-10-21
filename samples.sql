SELECT m.model_name, c.id, c.price, cp.code, max_discount.discount
FROM cars c
JOIN models m ON c.model_id = m.id
JOIN(
	SELECT MAX(cp.discount_percentage) AS discount, cpt.car_id
	FROM coupon_types cpt
	JOIN coupons cp ON cp.id = cpt.coupon_id
	GROUP BY cpt.car_id
) max_discount ON c.id = max_discount.car_id
JOIN coupons cp 
ON cp.discount_percentage=max_discount.discount;


SELECT m.model_name, b.brand_name, c.price, c.year 
FROM cars c
JOIN models m ON m.id = c.model_id
JOIN brands b ON b.id = m.brand_id;

SELECT i.image_url, i.description, i.car_id, c.price,c.year, m.model_name, b.brand_name
FROM cars c
LEFT JOIN images i ON i.car_id=c.id
JOIN models m ON m.id=c.model_id
JOIN brands b ON b.id=m.brand_id;

SELECT c.id, AVG(r.rating) AS avg_rating
FROM cars c
JOIN reviews r ON r.car_id=c.id
GROUP BY c.id
ORDER BY avg_rating DESC;

SELECT c.id, COUNT(r.id) AS total_reviews
FROM cars c
LEFT JOIN reviews r ON r.car_id=c.id
GROUP BY c.id
ORDER BY total_reviews DESC;

SELECT u.last_name, u.first_name, u.email, r.role_name
FROM users u
LEFT JOIN roles r ON u.role_id=r.id
ORDER BY u.last_name, u.first_name;

SELECT c.id, AVG(r.rating) AS avg_rating
FROM cars c
JOIN reviews r ON r.car_id=c.id
GROUP BY c.id
HAVING AVG(r.rating) > 3
ORDER BY avg_rating DESC;

WITH MaxDiscounts AS (
    SELECT 
        c.id AS car_id, 
        m.model_name, 
        cp.code, 
        cp.discount_percentage,
        ROW_NUMBER() OVER (PARTITION BY c.id ORDER BY cp.discount_percentage DESC) AS rn
    FROM cars c
    LEFT JOIN models m ON c.model_id = m.id
    JOIN coupon_types cpt ON cpt.car_id = c.id
    LEFT JOIN coupons cp ON cpt.coupon_id = cp.id
)
SELECT model_name, code, discount_percentage
FROM MaxDiscounts
WHERE rn = 1
ORDER BY model_name;

EXPLAIN 
WITH MaxDiscounts AS (
    SELECT 
        c.id AS car_id, 
        m.model_name, 
        cp.code, 
        cp.discount_percentage,
        ROW_NUMBER() OVER (PARTITION BY c.id ORDER BY cp.discount_percentage DESC) AS rn
    FROM cars c
    LEFT JOIN models m ON c.model_id = m.id
    JOIN coupon_types cpt ON cpt.car_id = c.id
    LEFT JOIN coupons cp ON cpt.coupon_id = cp.id
)
SELECT model_name, code, discount_percentage
FROM MaxDiscounts
WHERE rn = 1
ORDER BY model_name;

