## cloudwatch.tf
## aws_cloudwatch_metric_alarm.cpu
## aws_cloudwatch_metric_alarm.status

resource "aws_cloudwatch_metric_alarm" "cpu" {
  alarm_description   = var.cloudwatch_cpu
  alarm_name          = var.cloudwatch_cpu
  comparison_operator = "GreaterThanOrEqualToThreshold"
  datapoints_to_alarm = 1
  dimensions = {
    "InstanceId" = aws_instance.ec2.id
  }
  evaluation_periods        = 1
  insufficient_data_actions = []
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 300
  statistic                 = "Maximum"
  threshold                 = 90
  treat_missing_data        = "missing"
}

