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

# super.soで利用
resource "aws_route53_record" "mh4gf-dev-a" {
  name    = aws_route53_zone.mh4gf-dev.name
  zone_id = aws_route53_zone.mh4gf-dev.zone_id
  type    = "A"
  records = ["76.76.21.21"]
  ttl     = 300
}

resource "aws_route53_record" "mh4gf-dev-cname" {
  name    = "www"
  zone_id = aws_route53_zone.mh4gf-dev.zone_id
  type    = "CNAME"
  records = ["cname.super.so"]
  ttl     = 300
}

# https://log.mh4gf.dev
resource "aws_route53_record" "log-mh4gf-dev-txt" {
  zone_id = aws_route53_zone.mh4gf-dev.zone_id
  name    = "_vercel"
  type    = "TXT"
  ttl     = 300
  records = [
    "vc-domain-verify=log.mh4gf.dev,d7eebbd68388762f4485",
  ]
}

resource "aws_route53_record" "log-mh4gf-dev-cname" {
  name    = "log"
  zone_id = aws_route53_zone.mh4gf-dev.zone_id
  type    = "CNAME"
  records = ["cname.vercel-dns.com"]
  ttl     = 300
}
