terraform {
  backend "s3" {}
}

resource "aws_cloudwatch_event_rule" "this" {
  name        = substr(module.label.id, 0, 63)
  is_enabled  = var.cloudwatch_event_rule_is_enabled
  description = var.cloudwatch_event_rule_description != "" ? var.cloudwatch_event_rule_description : module.label.id

  event_pattern = jsonencode(var.cloudwatch_event_rule_pattern)
}

resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = var.cloudwatch_event_target_id
  arn       = var.cloudwatch_event_target_arn
}

