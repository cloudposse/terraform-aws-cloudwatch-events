locals {
  use_deprecated_enabled = (
    var.cloudwatch_event_rule_is_enabled != null &&
    var.cloudwatch_event_rule_state == "ENABLED"
  )

  cloudwatch_event_rule_state = local.use_deprecated_enabled ? (
    var.cloudwatch_event_rule_is_enabled == true ? "ENABLED" : "DISABLED"
  ) : var.cloudwatch_event_rule_state
}


module "rule_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  id_length_limit = 64

  context = module.this.context
}

resource "aws_cloudwatch_event_rule" "this" {
  name        = module.rule_label.id
  state       = local.cloudwatch_event_rule_state
  description = var.cloudwatch_event_rule_description != "" ? var.cloudwatch_event_rule_description : module.rule_label.id_full

  event_pattern = jsonencode(var.cloudwatch_event_rule_pattern)

  tags = module.this.tags
}

resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = var.cloudwatch_event_target_id
  arn       = var.cloudwatch_event_target_arn
  role_arn  = var.cloudwatch_event_target_role_arn
}

