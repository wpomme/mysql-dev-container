# 例
```
# title列のうち、mから始まるものを選択
SELECT title FROM film WHERE title LIKE 'm%';

# テーブルの詳細を表示
DESC actor;

# 組み込み関数や簡単な式の評価ならFROM句が不要
mysql> SELECT version(), user(), database();
+-----------+----------------+------------+
| version() | user()         | database() |
+-----------+----------------+------------+
| 8.0.44    | root@localhost | sakila     |
+-----------+----------------+------------+
```
