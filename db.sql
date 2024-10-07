CREATE OR REPLACE FUNCTION add_to_basket()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO baskets (user_id) VALUES (NEW.id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_user_insert
AFTER INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION add_to_basket();

INSERT INTO
	USERS (
		FIRST_NAME,
		LAST_NAME,
		EMAIL,
		PASSWORD_HASH,
		ROLE_ID
	)
VALUES
	(
		'John',
		'Doe',
		'johndoe@gmail.com',
		CRYPT('paveldurov', GEN_SALT ('des')),
		1
	),
	(
		'Vahen',
		'Mahen',
		'vahenmahen@gmail.com',
		CRYPT('vahen1234', GEN_SALT ('des')),
		1
	),
	(
		'Yahor',
		'Forynau',
		'yahorforynau@gmail.com',
		CRYPT('egorik_boxer1234', GEN_SALT ('des')),
		1
	),
	(
		'Paul',
		'Karaseu',
		'paulcarasev@gmail.com',
		CRYPT('paul_karasev_1234', GEN_SALT ('des')),
		1
	),
	(
		'Yulia',
		'Yulia',
		'yulia_yulia@gmail.com',
		CRYPT('yulia_1234', GEN_SALT ('des')),
		1
	);


INSERT INTO
	USERS (
		FIRST_NAME,
		LAST_NAME,
		EMAIL,
		PASSWORD_HASH,
		ROLE_ID
	)
VALUES
	(
		'Rostik',
		'Syn',
		'rostiksyn@gmail.com',
		CRYPT('rosto4eks', GEN_SALT ('des')),
		1
	);

INSERT INTO brands
(brand_name) VALUES
(
	'Mercedes'
),
(
	'Audi'
),
(
	'Alpha Romeo'
),
(
	'Aston Martin'
),
(
	'Bentley'
),
(
	'Mini'
),
(
	'Renault'
);

SELECT * FROM models;

SELECT * FROM brands;

INSERT INTO models
(model_name, brand_id) VALUES
(
	'XM',
	1
),
(
	'X6',
	1
),
(
	'X5',
	1
),
(
	'X6 M',
	1
),
(
	'X5 M',
	1
),
(
	'7',
	1
),
(
	'i7',
	1
),
(
	'E',
	2
),
(
	'C',
	2
),
(
	'S',
	2
),
(
	'GLS',
	2
),
(
	'GLE',
	2
),
(
	'M',
	2
);

SELECT * FROM models m
JOIN brands b ON(b.id = m.brand_id);

INSERT INTO cars
(model_id, price, year)
VALUES
(
	1,
	1000000,
	2020
),
(
	2,
	1000000,
	2022
),
(
	3,
	1000000,
	2018
);

SELECT * from cars;
UPDATE cars
SET id=id-4;

SELECT setval('cars_id_seq', 3);
INSERT INTO cars
(model_id, price, year)
VALUES
(
	4,
	1000000,
	2016
);


UPDATE baskets
SET id=id-1;
SELECT setval('baskets_id_seq',2);
SELECT * FROM basket_items;
INSERT INTO basket_items
(car_id, basket_id, amount)
VALUES
(
	1,
	1,
	2
),
(
	2,
	1,
	1
),
(
	2,
	2,
	1
);

INSERT INTO reviews
(car_id, user_id, rating, comment)
VALUES
(
	1,
	1,
	5,
	'Everything is fine'
),
(
	2,
	2,
	4,
	'Everything is fine, but...'
)
,
(
	3,
	3,
	3,
	'Everything is good'
),
(
	4,
	3,
	2,
	'Everything is bad'
);

ALTER TABLE logs
ALTER COLUMN action
TYPE varchar(30);

INSERT INTO logs
(user_id, action)
VALUES
(
	2,
	'Вышел из системы'
),
(
	3,
	'Добавил id=1 в корзину'
),
(
	3,
	'Удалил id=1'
);
SELECT m.model_name, c.id  FROM models m JOIN cars c ON (c.model_id=m.id);

INSERT INTO images
(car_id, image_url, description)
VALUES
(
	1,
	'images/bmwxm.png',
	'BMW XM'
),
(
	2,
	'images/bmwx6.png',
	'BMW X6'
),
(
	3,
	'images/bmwx5.png',
	'BMW X5'
),
(
	4,
	'images/bmwx6_m.png',
	'BMW X6'
);

