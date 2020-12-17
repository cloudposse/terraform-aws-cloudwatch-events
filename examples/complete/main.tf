provider "aws" {
  region = var.region
}

module "sns" {
  source  = "cloudposse/sns-topic/aws"
  version = "0.11.0"

  subscribers = var.sns_topic_subscribers

  allowed_aws_services_for_sns_published = var.sns_topic_allowed_aws_services_for_sns_published

  context = module.this.context
}

module "cloudwatch_event" {
  source = "../.."

  cloudwatch_event_rule_description = var.cloudwatch_event_rule_description
  cloudwatch_event_rule_pattern     = var.cloudwatch_event_rule_pattern
  cloudwatch_event_target_arn       = module.sns.sns_topic.arn

  context = module.this.context
}
