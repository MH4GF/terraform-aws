resource "aws_route53_zone" "cosmic-night-run" {
  name = "cosmicnight.run"
}

/* ブログ用 https://cosmicnight.run */
resource "aws_route53_record" "cosmic-night-run" {
  name    = aws_route53_zone.cosmic-night-run.name
  zone_id = aws_route53_zone.cosmic-night-run.id
  type    = "A"
  records = ["76.76.21.21"]
  ttl     = 300
}

# Google Domainsでドメインを管理し、ネームサーバーをAWSで管理する
resource "aws_route53_zone" "mh4gf-dev" {
  name = "mh4gf.dev"
}
