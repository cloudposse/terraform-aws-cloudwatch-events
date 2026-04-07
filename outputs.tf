output "aws_cloudwatch_event_rule_id" {
  description = "The name of the rule"
  value       = aws_cloudwatch_event_rule.this.id
}

output "aws_cloudwatch_event_rule_arn" {
  description = "The Amazon Resource Name (ARN) of the rule."
  value       = aws_cloudwatch_event_rule.this.arn
}

output "dead_letter_queue_arn" {
  description = "The ARN of the Dead Letter Queue."
  value       = try(aws_sqs_queue.dlq[0].arn, null)
}

output "dead_letter_queue_url" {
  description = "The URL of the Dead Letter Queue."
  value       = try(aws_sqs_queue.dlq[0].url, null)
}
