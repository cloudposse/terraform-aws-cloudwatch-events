module "rule_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  id_length_limit = 64

  context = module.this.context
}

resource "aws_cloudwatch_event_rule" "this" {
  name        = module.rule_label.id
  is_enabled  = var.cloudwatch_event_rule_is_enabled
  description = var.cloudwatch_event_rule_description != "" ? var.cloudwatch_event_rule_description : module.rule_label.id_full

  event_pattern = jsonencode(var.cloudwatch_event_rule_pattern)
}

resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = var.cloudwatch_event_target_id
  arn       = var.cloudwatch_event_target_arn
  role_arn  = var.cloudwatch_event_target_role_arn
}

