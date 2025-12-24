-- (1), (2) で取得される結果は同じ
-- (1) 映画とその映画に出ている俳優の一覧
SELECT
    f.title,
    a.first_name,
    a.last_name
FROM film AS f
INNER JOIN film_actor AS fa
    ON f.film_id = fa.film_id
INNER JOIN actor AS a
    ON fa.actor_id = a.actor_id;

-- (2) 俳優とその俳優が出ている映画の一覧
SELECT
    a.first_name,
    a.last_name,
    f.title
FROM actor AS a
INNER JOIN film_actor AS fa
    ON a.actor_id = fa.actor_id
INNER JOIN film AS f
    ON fa.film_id = f.film_id;

-- 文字列データ検証用のテーブルを作成する
CREATE TABLE string_tbl
  (char_fld CHAR(30),
   vchar_fld VARCHAR(30),
   text_fld TEXT);

DELETE FROM string_tbl;
INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
 VALUE ('This string is 28 characters',
       'This string is 28 characters',
       'This string is 28 characters');

SELECT LENGTH(char_fld) char_length,
       LENGTH(vchar_fld) varchar_length,
       LENGTH(text_fld) text_length
FROM string_tbl;

-- categoryのname行にあるyで終わる文字列を検索
SELECT name, name LIKE '%y' ends_in_y
  FROM category;

-- 姓と名を結合して文字列を返す
SELECT concat(first_name, ' ', last_name) AS full_name FROM actor LIMIT 10;

SELECT
    f.title,
    concat(a.first_name, ' ', a.last_name) AS full_name
FROM film AS f
INNER JOIN film_actor AS fa
    ON f.film_id = fa.film_id
INNER JOIN actor AS a
    ON fa.actor_id = a.actor_id
    GROUP BY concat(a.first_name, ' ', a.last_name);

-- 集計関数
-- paymentテーブルを使用する
SELECT MAX(amount) max_amt,
       MIN(amount) min_amt,
       AVG(amount) avg_amt,
       SUM(amount) tot_amt,
       COUNT(*) num_payments
FROM payment;

-- customer_id で集計する場合は、GROUP BY句を付けて、データをグループ化する方法を明示的に指定する
SELECT customer_id,
       MAX(amount) max_amt,
       MIN(amount) min_amt,
       AVG(amount) avg_amt,
       SUM(amount) tot_amt,
       COUNT(*) num_payments
FROM payment
GROUP BY customer_id;

-- 各俳優が出演している映画の本数を集計する
SELECT actor_id, count(*)
FROM film_actor
GROUP BY actor_id LIMIT 5;

-- 各俳優が出演している映画の本数をレーティングごとに集計する
SELECT fa.actor_id, f.rating, count(*)
FROM film_actor AS fa
INNER JOIN film AS f
    ON fa.film_id = f.film_id
GROUP BY fa.actor_id, f.rating
ORDER BY 1, 2 LIMIT 5;

-- サブクエリ
-- (1), (2) で取得される結果は同じ
-- (1)
SELECT Name FROM city WHERE CountryCode = 'JPN';

-- (2)
SELECT Name FROM city WHERE CountryCode = (
    SELECT Code FROM country WHERE Name = 'Japan'
);

-- 複数行のサブクエリ
-- 1. ラストネームがMONROEである俳優を選択
-- 2. レーティングがPGである映画を選択
-- -> Monroeという俳優が出演した映画のレーティングがPGだったケースを取得している
-- (1), (2) で取得される結果は同じ
-- (1)
SELECT fa.actor_id, fa.film_id
FROM film_actor AS fa
WHERE fa.actor_id IN
    (SELECT actor_id FROM actor WHERE last_name = 'MONROE')
    AND fa.film_id IN
    (SELECT film_id FROM film WHERE rating = 'PG');

-- (2)
-- クロス結合を使う
SELECT actor_id, film_id
FROM film_actor
WHERE (actor_id, film_id) IN
    (SELECT a.actor_id, f.film_id
     FROM actor AS a
         CROSS JOIN film AS f
         WHERE a.last_name = 'MONROE' AND f.rating = 'PG'
    );

-- 相関サブクエリ
-- 顧客ごとにレンタルの回数を数えた後、外側のクエリでレンタル回数がちょうど20回の顧客を取得する
-- クエリの実行回数に注意
SELECT c.first_name, c.last_name
FROM customer AS c
WHERE 20 =
    (SELECT count(*)
     FROM rental AS r
     WHERE r.customer_id = c.customer_id
    );

-- 相関サブクエリはexists演算子をよく使う
-- 2005年5月25日よりも前に映画を少なくとも１本レンタルした顧客を取得する
SELECT c.first_name, c.last_name
FROM customer AS c
WHERE EXISTS
    (SELECT 1 FROM rental AS r
     WHERE r.customer_id = c.customer_id
       AND date(r.rental_date) < '2025-05-25');
