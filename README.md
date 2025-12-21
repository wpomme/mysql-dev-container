# mysql-dev-container
実習用のMySQLコンテナを作成するためのリポジトリ
データベースにはsakilaなどを使う
rootユーザーで操作するなど、適当な権限割り振り、セキュリティ

# セットアップ
## 共通
dockerコンテナにデータベースのデータをコピー
``` sh
docker cp ./share_data/sakila-db dev:/home/
``` 

## 実行結果の例
command-example.mdに記載

## sakila
- Installation
document: https://dev.mysql.com/doc/sakila/en/sakila-installation.html

```sh
# dockerコンテナにログイン
docker exec -it dev /bin/bash
# DBを投入
# この方法だとrootユーザーでしかテーブルを確認できない
mysql -uroot -pdevpass -t < sakila-schema.sql
mysql -uroot -pdevpass -t < sakila-data.sql
# rootユーザーでログイン
mysql -uroot -pdevpass
# sakilaテーブルの内容を確認
mysql -uroot -pdevpass -Dsakila
mysql> show tables;
```

## world
- Installation

## Linter
- 試しにsqruffを導入してみた。.sqruffファイルを作成してからlintを実行する。
```
sqruff lint sql-examle.sql
sqruff fix sql-examle.sql
```
