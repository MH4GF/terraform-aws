# terraform-aws

個人開発で使うterraformリソース

# usage

## 環境変数の追加

```
cp .env.example .env
# AWSのアクセスキーなどを追加
```

## docker-composeで操作
```
docker-compose up --build -d
docker-compose exec terraform sh

terraform init
```
