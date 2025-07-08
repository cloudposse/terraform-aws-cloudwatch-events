variable "cloudwatch_event_rule_is_enabled" {
  type        = bool
  description = "DEPRECATED (use `cloudwatch_event_rule_state` instead): Whether the rule should be enabled. Conflicts with `cloudwatch_event_rule_is_enabled`"
  default     = null
}
