module "rule_label" {
  source  = "cloudposse/label/null"
  version = "0.22.0" // requires Terraform >= 0.12.26

  id_length_limit = 64

  context = module.this.context
}

resource "aws_cloudwatch_event_rule" "this" {
  # If `name_prefix` is set (not null) then do not set `name`
  name        = var.cloudwatch_event_name_prefix != null ?  null : module.rule_label.id
  name_prefix  = var.cloudwatch_event_name_prefix
  is_enabled  = var.cloudwatch_event_rule_is_enabled
  description = var.cloudwatch_event_rule_description != "" ? var.cloudwatch_event_rule_description : module.rule_label.id_full

  event_pattern = jsonencode(var.cloudwatch_event_rule_pattern)
}

resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = var.cloudwatch_event_target_id
  arn       = var.cloudwatch_event_target_arn
}
