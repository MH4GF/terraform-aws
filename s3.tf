resource "aws_s3_bucket" "ort-aws-log" {
  bucket = "ort-aws-log"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      bucket_key_enabled = true

      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.ort-aws-log-kms-key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "ort-aws-log" {
  bucket = aws_s3_bucket.ort-aws-log.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_policy" "ort-aws-log" {
  bucket = aws_s3_bucket.ort-aws-log.id
  policy = data.aws_iam_policy_document.ort-aws-log.json
}

data "aws_iam_policy_document" "ort-aws-log" {
  statement {
    sid       = "AWSCloudTrailAclCheck20150319"
    effect    = "Allow"
    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.ort-aws-log.arn]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }

  statement {
    sid       = "AWSCloudTrailWrite20150319"
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.ort-aws-log.arn}/AWSLogs/${data.aws_caller_identity.self.id}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}
