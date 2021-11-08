resource "aws_cloudtrail" "ort" {
  name                          = "ort"
  s3_bucket_name                = aws_s3_bucket.ort-aws-log.id
  is_multi_region_trail         = true
  is_organization_trail         = false # organizationがないため一旦false
  kms_key_id                    = aws_kms_key.ort-cloudtrail.arn
  enable_log_file_validation    = true
  include_global_service_events = true
}
