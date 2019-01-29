variable "sns-topic-arn" {
  description = "Specific SNS ARN"
  type = "string"
}

variable "elasticache_cluster_id" {
  description = "Elasticache cluster ID you want to monitor."
  type        = "string"
}

variable "cpu_utilization_threshold" {
  description = "The maximum percentage of CPU utilization."
  type        = "string"
  default     = 80
}

variable "freeable_memory_threshold" {
  description = "The minimum amount of available random access memory in Byte."
  type        = "string"
  default     = 64000000

  # 64 Megabyte in Byte
}

variable "swap_usage_threshold" {
  description = "The maximum amount of swap space used on the DB instance in Byte."
  type        = "string"
  default     = 256000000

  # 256 Megabyte in Byte
}