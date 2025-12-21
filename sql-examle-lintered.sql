-- 顧客ごとの姓と名、住所を取得
SELECT
    c.first_name,
    c.last_name,
    a.address
FROM customer AS c INNER JOIN address AS a
    ON c.address_id = a.address_id;

-- 住所とその街と国の情報を取得
SELECT
    a.address,
    a.address2,
    c.city,
    co.country
FROM address AS a
INNER JOIN city AS c
    ON a.city_id = c.city_id
INNER JOIN country AS co
    ON c.country_id = co.country_id;
-- WHERE a.address2 is not NULL;
-- LIMIT 10;
