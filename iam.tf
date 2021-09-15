resource "aws_iam_account_alias" "ort-dev" {
  account_alias = "ort-dev"
}

# https://github.com/MH4GF/terraform-aws のGitHub Actions
resource "aws_iam_user" "github-actions" {
  name = "github-actions"
}

# GPG鍵の管理が辛いので、コンソール上で作ったアクセスキーをimportした
resource "aws_iam_access_key" "github-actions" {
  user = aws_iam_user.github-actions.name
}
