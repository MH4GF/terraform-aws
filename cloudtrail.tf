resource "aws_cloudtrail" "ort" {
  name                  = "ort"
  s3_bucket_name        = aws_s3_bucket.ort-aws-log.id
  is_multi_region_trail = true
  is_organization_trail = false # organizationがないため一旦false
}
