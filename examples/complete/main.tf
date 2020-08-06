provider "aws" {
  region = var.region
}

module "sns" {
  source = "git::https://github.com/cloudposse/terraform-aws-sns-topic.git?ref=tags/0.2.0"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  subscribers = var.sns_topic_subscribers

  allowed_aws_services_for_sns_published = var.sns_topic_allowed_aws_services_for_sns_published
}

module "cloudwatch_event" {
  source = "../.."

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  cloudwatch_event_rule_description = var.cloudwatch_event_rule_description
  cloudwatch_event_rule_pattern     = var.cloudwatch_event_rule_pattern
  cloudwatch_event_target_arn       = module.sns.sns_topic.arn
}
