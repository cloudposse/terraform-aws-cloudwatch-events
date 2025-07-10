variable "cloudwatch_event_rule_description" {
  type        = string
  description = "The description of the rule."
  default     = ""
}

variable "cloudwatch_event_rule_pattern" {
  description = "Event pattern described a HCL map which will be encoded as JSON with jsonencode function. See full documentation of CloudWatch Events and Event Patterns for details. http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/CloudWatchEventsandEventPatterns.html"
}

variable "cloudwatch_event_rule_state" {
  type        = string
  description = <<-EOT
    State of the rule. Valid values are DISABLED, ENABLED, and ENABLED_WITH_ALL_CLOUDTRAIL_MANAGEMENT_EVENTS.
    When state is ENABLED, the rule is enabled for all events except those delivered by CloudTrail.
    To also enable the rule for events delivered by CloudTrail, set state to ENABLED_WITH_ALL_CLOUDTRAIL_MANAGEMENT_EVENTS.
    EOT
  default     = "ENABLED"
}

variable "cloudwatch_event_target_id" {
  type        = string
  description = "The unique target assignment ID. If missing, will generate a random, unique id."
  default     = null
}

variable "cloudwatch_event_target_arn" {
  type        = string
  description = "The Amazon Resource Name (ARN) associated of the target."
}

variable "cloudwatch_event_target_role_arn" {
  type        = string
  description = "IAM role to be used for this target when the rule is triggered."
  default     = null
}
