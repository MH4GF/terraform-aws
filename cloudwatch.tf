resource "aws_cloudwatch_metric_alarm" "billing-alarm" {
  provider                  = aws.us-east-1 # 請求アラームはus-east-1でしか登録できない
  alarm_name                = "BillingAlarm"
  comparison_operator       = "GreaterThanThreshold"
  datapoints_to_alarm       = 1
  evaluation_periods        = "1"
  metric_name               = "EstimatedCharges"
  namespace                 = "AWS/Billing"
  period                    = "21600" # 6時間
  statistic                 = "Maximum"
  threshold                 = "1000" # 1000円を越えたら通知
  insufficient_data_actions = []

  dimensions = {
    Currency = "JP"
  }
  alarm_actions = [
    aws_sns_topic.ort-alert-us-east-1.arn,
  ]
  ok_actions = [
    aws_sns_topic.ort-alert-us-east-1.arn,
  ]
}
