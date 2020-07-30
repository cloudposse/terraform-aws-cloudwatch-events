## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0, < 0.14.0 |
| local | ~> 1.2 |
| random | ~> 2.2 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_tag\_map | Additional tags for appending to each tag map | `map(string)` | `{}` | no |
| attributes | Any extra attributes for naming these resources | `list(string)` | `[]` | no |
| cloudwatch\_event\_rule\_description | The description of the rule. | `string` | `""` | no |
| cloudwatch\_event\_rule\_is\_enabled | Whether the rule should be enabled. | `bool` | `true` | no |
| cloudwatch\_event\_rule\_pattern\_json | (Required, if schedule\_expression isn't specified) Event pattern described a JSON object. See full documentation of CloudWatch Events and Event Patterns for details. http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/CloudWatchEventsandEventPatterns.html | `string` | n/a | yes |
| cloudwatch\_event\_target\_arn | The Amazon Resource Name (ARN) associated of the target. | `string` | n/a | yes |
| cloudwatch\_event\_target\_id | The unique target assignment ID. If missing, will generate a random, unique id. | `string` | `null` | no |
| context | Default context to use for passing state between label invocations | <pre>object({<br>    namespace           = string<br>    environment         = string<br>    stage               = string<br>    name                = string<br>    enabled             = bool<br>    delimiter           = string<br>    attributes          = list(string)<br>    label_order         = list(string)<br>    tags                = map(string)<br>    additional_tag_map  = map(string)<br>    regex_replace_chars = string<br>  })</pre> | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": "",<br>  "enabled": true,<br>  "environment": "",<br>  "label_order": [],<br>  "name": "",<br>  "namespace": "",<br>  "regex_replace_chars": "",<br>  "stage": "",<br>  "tags": {}<br>}</pre> | no |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name` and `attributes` | `string` | `"-"` | no |
| environment | The environment name if not using stage | `string` | `""` | no |
| label\_order | The naming order of the ID output and Name tag | `list(string)` | `[]` | no |
| name | Solution name, e.g. 'app' or 'cluster' | `string` | `""` | no |
| namespace | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `""` | no |
| regex\_replace\_chars | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`. By default only hyphens, letters and digits are allowed, all other chars are removed | `string` | `"/[^a-zA-Z0-9-]/"` | no |
| stage | Stage, e.g. 'prod', 'staging', 'dev', or 'test' | `string` | `""` | no |
| tags | Additional tags to apply to all resources that use this label module | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_cloudwatch\_event\_rule\_arn | The Amazon Resource Name (ARN) of the rule. |
| aws\_cloudwatch\_event\_rule\_id | The name of the rule |

