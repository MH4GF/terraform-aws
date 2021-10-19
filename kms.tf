resource "aws_kms_key" "ort-cloudtrail" {
  description         = "cloudtrail key"
  is_enabled          = true
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.ort-cloudtrail-kms-key.json
}

resource "aws_kms_alias" "ort-cloudtrail" {
  name          = "alias/ort/cloudtrail"
  target_key_id = aws_kms_key.ort-cloudtrail.key_id
}

data "aws_iam_policy_document" "ort-cloudtrail-kms-key" {
  statement {
    actions = [
      "kms:*",
    ]
    principals {
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.self.account_id}:root",
      ]
      type = "AWS"
    }
    resources = [
      "*",
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["kms:GenerateDataKey*"]
    resources = ["*"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = ["arn:aws:cloudtrail:*:${data.aws_caller_identity.self.id}:trail/*"]
    }
  }

  statement {
    actions = [
      "kms:DescribeKey",
    ]
    principals {
      identifiers = [
        "cloudtrail.amazonaws.com",
      ]
      type = "Service"
    }
    resources = [
      "*",
    ]
    sid = "Allow CloudTrail to describe key"
  }
}
