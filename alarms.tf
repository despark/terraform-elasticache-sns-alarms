locals {
  thresholds = {
    CPUUtilizationThreshold   = "${min(max(var.cpu_utilization_threshold, 0), 100)}"
    FreeableMemoryThreshold   = "${max(var.freeable_memory_threshold, 0)}"
    SwapUsageThreshold        = "${max(var.swap_usage_threshold, 0)}"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_too_high" {
  alarm_name          = "elastic_cache_cpu_utilization_too_high_${var.elasticache_cluster_id}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = "600"
  statistic           = "Average"
  threshold           = "${local.thresholds["CPUUtilizationThreshold"]}"
  alarm_description   = "Average database CPU utilization over last 10 minutes too high"
  alarm_actions       = ["${var.sns-topic-arn}"]
  ok_actions          = ["${var.sns-topic-arn}"]

  dimensions = {
    CacheClusterId = "${var.elasticache_cluster_id}"
  }
}

resource "aws_cloudwatch_metric_alarm" "freeable_memory_too_low" {
  alarm_name          = "elastic_cache_freeable_memory_too_low_${var.elasticache_cluster_id}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeableMemory"
  namespace           = "AWS/ElastiCache"
  period              = "600"
  statistic           = "Average"
  threshold           = "${local.thresholds["FreeableMemoryThreshold"]}"
  alarm_description   = "Average database freeable memory over last 10 minutes too low, performance may suffer"
  alarm_actions       = ["${var.sns-topic-arn}"]
  ok_actions          = ["${var.sns-topic-arn}"]

  dimensions = {
    CacheClusterId = "${var.elasticache_cluster_id}"
  }
}

resource "aws_cloudwatch_metric_alarm" "swap_usage_too_high" {
  alarm_name          = "elastic_cache_swap_usage_too_high_${var.elasticache_cluster_id}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "SwapUsage"
  namespace           = "AWS/ElastiCache"
  period              = "600"
  statistic           = "Average"
  threshold           = "${local.thresholds["SwapUsageThreshold"]}"
  alarm_description   = "Average database swap usage over last 10 minutes too high, performance may suffer"
  alarm_actions       = ["${var.sns-topic-arn}"]
  ok_actions          = ["${var.sns-topic-arn}"]

  dimensions = {
    CacheClusterId = "${var.elasticache_cluster_id}"
  }
}
