# CloudWatch Alarm → SNS Topic → ChatbotでSlackに通知している。
# AWS Chatbotはterraformでまだ対応していないため、手動で作成する。
resource "aws_sns_topic" "ort-alert-us-east-1" {
  name         = "ort-alert-us-east-1"
  display_name = "ort-alert-us-east-1"
  policy       = data.aws_iam_policy_document.ort-alert-us-east-1.json
  provider     = aws.us-east-1 # 請求アラートはus-east-1でしか作成できないため、そこから通知できるようにする。
}

data "aws_iam_policy_document" "ort-alert-us-east-1" {
  version = "2008-10-17"

  statement {
    effect = "Allow"

    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:DeleteTopic",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
      "SNS:Receive",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"
      values = [
        data.aws_caller_identity.self.account_id
      ]
    }

    resources = [
      "arn:aws:sns:us-east-1:${data.aws_caller_identity.self.account_id}:ort-alert-us-east-1"
    ]

    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
  }
}
