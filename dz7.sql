use shop;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

INSERT INTO `orders` VALUES (1,1,'2011-09-08 21:03:14','1975-07-07 22:05:02'),(2,2,'2004-02-15 08:25:37','1991-02-15 20:48:02'),(3,3,'1993-01-10 22:31:30','1972-07-24 03:06:58'),(4,4,'1971-09-26 19:06:24','1986-02-23 10:23:10'),(5,5,'1973-12-31 08:33:41','1976-11-27 15:49:08'),(6,6,'1993-06-20 02:11:22','2011-07-19 15:31:23'),(7,1,'1991-09-26 17:12:19','1984-03-10 15:51:54'),(8,2,'1975-10-09 21:26:40','1980-06-19 00:45:10'),(9,3,'2020-04-01 13:36:38','2006-01-22 21:40:37'),(10,4,'1989-08-09 02:46:12','2012-08-30 21:56:34'),(11,5,'1993-09-06 08:06:02','1985-08-16 14:40:28'),(12,6,'2014-07-12 09:46:34','2002-08-29 02:53:32'),(13,1,'2017-05-02 11:16:28','1997-07-29 15:39:53'),(14,2,'1973-07-14 06:45:22','2005-01-20 11:23:35'),(15,3,'1977-01-17 21:10:24','1993-02-12 03:04:57');

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

INSERT INTO `orders_products` VALUES (1,1,1,3,'1999-12-18 19:58:51','1970-01-13 14:05:21'),(2,2,2,9,'1998-12-31 13:00:05','1992-12-02 01:43:53'),(3,3,3,6,'1973-09-20 00:57:09','1996-12-02 12:29:02'),(4,4,4,1,'2005-12-07 04:43:31','2013-05-09 04:18:25'),(5,5,5,6,'1998-01-23 19:09:59','1983-07-08 07:23:56'),(6,6,6,1,'1992-06-11 23:45:13','1977-01-03 21:27:43'),(7,7,7,1,'2016-05-08 07:46:15','1976-06-08 06:34:15'),(8,8,1,1,'1993-11-26 18:01:08','1979-07-10 00:02:44'),(9,9,2,1,'1976-12-06 21:09:09','1991-07-05 18:06:15'),(10,10,3,9,'2008-08-27 18:04:14','2009-03-14 03:37:32'),(11,11,4,6,'1995-02-16 23:00:08','1972-05-18 09:13:42'),(12,12,5,2,'1993-06-18 12:26:40','1990-06-09 12:54:07'),(13,13,6,3,'2014-09-09 04:37:47','2012-11-18 20:43:35'),(14,14,7,5,'2005-01-03 01:11:44','1998-02-08 03:15:46'),(15,15,1,5,'2011-01-07 23:04:13','1987-11-03 09:19:36');

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

INSERT INTO `discounts` VALUES (1,1,1,1,'1984-01-26 20:59:38','1973-11-09 06:43:15','1988-07-25 21:56:38','2001-08-26 04:06:47'),(2,2,2,5,'1970-01-18 18:33:46','1979-03-04 23:09:52','2003-06-07 21:24:51','2018-03-15 20:43:55'),(3,3,3,53440900,'1972-08-01 18:06:29','2018-03-10 10:54:57','2000-06-17 11:28:01','2010-12-31 23:09:38'),(4,4,4,40,'2020-08-03 23:21:45','1991-03-18 15:58:11','2012-05-02 11:06:43','1974-04-26 08:01:01'),(5,5,5,1905570,'1985-11-21 18:10:43','1985-10-07 00:51:31','1989-03-31 05:04:55','2017-07-21 20:32:51'),(6,6,6,516518,'2000-02-07 21:16:33','1991-02-17 04:36:37','1991-04-02 18:28:20','1982-02-08 20:41:42'),(7,1,7,878819,'1971-01-22 11:54:31','1987-04-19 06:07:41','2009-07-21 21:07:22','2016-09-07 11:15:20'),(8,2,1,5,'1978-08-26 11:33:02','2012-10-13 14:02:21','1979-04-15 09:36:00','2007-06-07 09:35:20'),(9,3,2,6409280,'1984-03-24 09:31:24','1999-11-10 05:35:40','1996-02-02 00:27:59','1992-08-28 10:40:13'),(10,4,3,10842,'2005-02-06 02:09:47','1974-04-13 01:24:56','1973-09-16 16:23:15','1988-06-25 20:25:55'),(11,5,4,92809,'1998-12-27 10:54:02','1997-08-25 01:21:19','1978-08-22 08:03:10','1976-04-29 16:07:35'),(12,6,5,37535,'2016-06-13 14:54:39','2008-07-17 17:36:06','2010-01-22 14:21:35','1974-08-28 03:52:02'),(13,1,6,52096800,'1993-04-25 11:30:12','2012-06-17 22:52:18','1993-05-28 09:59:34','1972-10-13 22:21:43'),(14,2,7,41751000,'1995-03-14 13:43:34','1972-07-02 16:01:15','2011-07-30 18:10:56','2013-08-13 13:37:06'),(15,3,1,88827,'1988-10-13 14:49:17','2019-03-07 14:19:58','1972-11-03 08:29:22','1985-08-31 00:44:44');

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

INSERT INTO `storehouses` VALUES (1,'et','2014-02-20 08:48:33','2007-10-11 03:46:39'),(2,'explicabo','1995-07-01 20:13:17','2017-06-19 15:21:08'),(3,'dolor','1995-10-15 23:30:33','2006-03-06 22:47:55'),(4,'voluptatem','1993-05-12 15:42:29','2015-12-27 19:02:04'),(5,'sit','2018-12-21 22:44:27','2011-12-25 00:43:27'),(6,'sunt','2016-11-01 12:42:43','1985-10-06 04:24:24'),(7,'sit','2004-01-22 02:21:50','1998-10-29 10:12:19'),(8,'est','2012-03-06 20:29:41','2006-09-24 13:30:54'),(9,'numquam','2017-12-29 09:45:25','1976-07-11 22:08:48'),(10,'nesciunt','1987-10-29 05:19:18','1989-04-11 12:29:48'),(11,'autem','1972-03-10 21:23:02','2019-02-22 02:33:37'),(12,'quia','1983-03-12 15:32:59','2017-08-28 08:20:14'),(13,'ut','1997-05-02 11:19:21','2000-11-30 15:16:45'),(14,'ducimus','1980-05-22 00:54:03','1973-05-25 17:51:21'),(15,'consequuntur','1999-05-09 08:22:06','1976-04-30 14:57:08');

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO `storehouses_products` VALUES (1,1,1,7,'2011-04-27 03:21:29','2007-12-18 21:32:39'),(2,2,2,1,'1972-07-12 04:07:36','1985-08-02 19:15:08'),(3,3,3,7,'1991-11-04 14:43:43','2008-05-06 04:01:13'),(4,4,4,7,'1990-07-10 05:29:34','1988-07-14 07:03:44'),(5,5,5,5,'2019-02-20 04:32:50','1999-03-04 08:32:24'),(6,6,6,1,'1981-03-28 13:53:53','2015-06-29 17:11:07'),(7,7,7,7,'1971-02-18 15:41:31','2015-06-23 10:58:56'),(8,8,1,6,'1982-05-30 13:06:11','2010-01-11 14:09:49'),(9,9,2,6,'2005-09-24 04:31:29','1973-04-01 18:42:38'),(10,10,3,6,'2011-08-23 06:29:14','2011-11-25 17:53:24'),(11,11,4,1,'1973-01-23 20:19:18','2013-08-24 09:03:42'),(12,12,5,3,'1998-01-03 16:34:36','2007-10-15 18:20:05'),(13,13,6,1,'1989-04-06 03:08:59','2011-04-20 10:43:56'),(14,14,7,7,'1997-03-14 18:32:10','1978-05-03 13:20:56'),(15,15,1,1,'1999-02-16 12:30:45','2006-03-31 17:16:35');


# Далее следует ДЗ

# 1. Cписок пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT 
	users.id, 
    users.name,
	orders.id AS order_id
FROM 
	users
RIGHT JOIN
	orders
ON
	users.id = orders.user_id;
    
# 2. Cписок товаров products и разделов catalogs, который соответствует товару.

SELECT 
    products.name,
	catalogs.name AS cat_name
FROM
	products
JOIN
	catalogs
ON 
	products.catalog_id = catalogs.id; 
 
 /*
	3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
		Поля from, to и label содержат английские названия городов, поле name — русское.
		Выведите список рейсов flights с русскими названиями городов.
*/
    
SELECT
	(SELECT name FROM cities WHERE label = `from`) AS `отправление`,
	(SELECT name FROM cities WHERE label = `to`) AS `прибытие`
FROM
	flights
ORDER BY
	flights.id;