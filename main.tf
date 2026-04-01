locals {
  cloudwatch_event_rule_state = (
    var.cloudwatch_event_rule_is_enabled == null
    ? var.cloudwatch_event_rule_state
    : (var.cloudwatch_event_rule_is_enabled ? "ENABLED" : "DISABLED")
  )
  dlq_enabled = module.this.enabled && var.dead_letter_queue_enabled
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

  dynamic "dead_letter_config" {
    for_each = local.dlq_enabled ? [1] : []
    content {
      arn = aws_sqs_queue.dlq[0].arn
    }
  }
}

# Dead Letter Queue for failed event deliveries
# When EventBridge fails to deliver an event to a target, the event is normally dropped.
# Enabling a DLQ captures failed events for troubleshooting delivery issues (e.g., permission errors).
module "dlq_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  enabled    = local.dlq_enabled
  attributes = ["dlq"]
  context    = module.this.context
}

resource "aws_sqs_queue" "dlq" {
  count = local.dlq_enabled ? 1 : 0

  name                      = module.dlq_label.id
  message_retention_seconds = var.dead_letter_queue_message_retention_seconds
  tags                      = module.dlq_label.tags
}

data "aws_iam_policy_document" "dlq_policy" {
  count = local.dlq_enabled ? 1 : 0

  statement {
    sid    = "AllowEventBridgeToSendMessages"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.dlq[0].arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudwatch_event_rule.this.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "dlq" {
  count = local.dlq_enabled ? 1 : 0

  queue_url = aws_sqs_queue.dlq[0].id
  policy    = data.aws_iam_policy_document.dlq_policy[0].json
}

