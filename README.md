# terraform-aws

個人開発で使うterraformリソース

## 方針

- 課題が出るまではディレクトリはわけずに1回のplanで全てを読み込む
- publicリポジトリなのでセキュリティ上の問題からCIでのplanはやらない。ローカルでのapplyを良しとする。
- インフラ構成は頻繁に保守しないため基本忘れるものとし、コードコメントを多めに書く

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

terraform plan
```