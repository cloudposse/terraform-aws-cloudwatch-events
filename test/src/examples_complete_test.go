package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.us-east-2.tfvars"},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	outputCloudWatchEventRuleARN := terraform.Output(t, terraformOptions, "aws_cloudwatch_event_rule_arn")

	// Verify that ARN for CloudWatch Event Rula is created as expected
	assert.Regexp(t, "^arn:aws:events:us-east-2:\\d+:rule\\/eg-test-health-ec2-issue\\d+$", outputCloudWatchEventRuleARN)


}
