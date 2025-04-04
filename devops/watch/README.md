## Requirements

| Name                                                                     | Version   |
| ------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | = 1.2.6   |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 4.23.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement_tfe)                   | >= 0.35.0 |

## Providers

| Name                                                                           | Version |
| ------------------------------------------------------------------------------ | ------- |
| <a name="provider_aws.us-east-1"></a> [aws.us-east-1](#provider_aws.us-east-1) | 4.23.0  |
| <a name="provider_terraform"></a> [terraform](#provider_terraform)             | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                        | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_cloudformation_stack.alert-watch-sev1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                               | resource    |
| [aws_cloudformation_stack.alert-watch-sev2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                               | resource    |
| [aws_cloudformation_stack.dev-watch-alexa-cache-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                        | resource    |
| [aws_cloudformation_stack.dev-watch-alexa-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                            | resource    |
| [aws_cloudformation_stack.dev-watch-alexa-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                       | resource    |
| [aws_cloudformation_stack.dev-watch-alexa-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                        | resource    |
| [aws_cloudformation_stack.dev-watch-alexa-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                             | resource    |
| [aws_cloudformation_stack.dev-watch-alexa-supercronic-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)           | resource    |
| [aws_cloudformation_stack.dev-watch-alexa-supercronic-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)            | resource    |
| [aws_cloudformation_stack.dev-watch-assets-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                           | resource    |
| [aws_cloudformation_stack.dev-watch-assets-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                      | resource    |
| [aws_cloudformation_stack.dev-watch-cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                              | resource    |
| [aws_cloudformation_stack.dev-watch-cplay-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                            | resource    |
| [aws_cloudformation_stack.dev-watch-cplay-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                       | resource    |
| [aws_cloudformation_stack.dev-watch-cplay-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                        | resource    |
| [aws_cloudformation_stack.dev-watch-cplay-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                             | resource    |
| [aws_cloudformation_stack.dev-watch-cropper-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                          | resource    |
| [aws_cloudformation_stack.dev-watch-cropper-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                     | resource    |
| [aws_cloudformation_stack.dev-watch-cropper-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                      | resource    |
| [aws_cloudformation_stack.dev-watch-cropper-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                           | resource    |
| [aws_cloudformation_stack.dev-watch-editorials-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                       | resource    |
| [aws_cloudformation_stack.dev-watch-editorials-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                  | resource    |
| [aws_cloudformation_stack.dev-watch-player-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                           | resource    |
| [aws_cloudformation_stack.dev-watch-player-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                      | resource    |
| [aws_cloudformation_stack.dev-watch-queues-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                           | resource    |
| [aws_cloudformation_stack.dev-watch-queues-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                      | resource    |
| [aws_cloudformation_stack.dev-watch-queues-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                       | resource    |
| [aws_cloudformation_stack.dev-watch-queues-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                            | resource    |
| [aws_cloudformation_stack.dev-watch-webcenter-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                        | resource    |
| [aws_cloudformation_stack.dev-watch-webcenter-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                   | resource    |
| [aws_cloudformation_stack.dev-watch-webcenter-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                    | resource    |
| [aws_cloudformation_stack.dev-watch-webcenter-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                         | resource    |
| [aws_cloudformation_stack.dev-watch-wp-avod-ingest-supercronic-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)  | resource    |
| [aws_cloudformation_stack.dev-watch-wp-avod-ingest-supercronic-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)   | resource    |
| [aws_cloudformation_stack.dev-watch-wp-avod-supercronic-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)         | resource    |
| [aws_cloudformation_stack.dev-watch-wp-avod-supercronic-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)          | resource    |
| [aws_cloudformation_stack.dev-watch-wp-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                               | resource    |
| [aws_cloudformation_stack.dev-watch-wp-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                          | resource    |
| [aws_cloudformation_stack.dev-watch-wp-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                           | resource    |
| [aws_cloudformation_stack.dev-watch-wp-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                                | resource    |
| [aws_cloudformation_stack.dev-watch-wp-svod-ingest-supercronic-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)  | resource    |
| [aws_cloudformation_stack.dev-watch-wp-svod-ingest-supercronic-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)   | resource    |
| [aws_cloudformation_stack.dev-watch-wp-svod-supercronic-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)         | resource    |
| [aws_cloudformation_stack.dev-watch-wp-svod-supercronic-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)          | resource    |
| [aws_cloudformation_stack.dev-watch-wpalpha-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                          | resource    |
| [aws_cloudformation_stack.dev-watch-wpalpha-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                     | resource    |
| [aws_cloudformation_stack.dev-watch-wpalpha-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                      | resource    |
| [aws_cloudformation_stack.dev-watch-wpalpha-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                           | resource    |
| [aws_cloudformation_stack.dev-webcenter-cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                          | resource    |
| [aws_cloudformation_stack.prod-watch-alexa-cache-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                       | resource    |
| [aws_cloudformation_stack.prod-watch-alexa-dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                     | resource    |
| [aws_cloudformation_stack.prod-watch-alexa-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                           | resource    |
| [aws_cloudformation_stack.prod-watch-alexa-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                      | resource    |
| [aws_cloudformation_stack.prod-watch-alexa-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                       | resource    |
| [aws_cloudformation_stack.prod-watch-alexa-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                            | resource    |
| [aws_cloudformation_stack.prod-watch-alexa-supercronic-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)          | resource    |
| [aws_cloudformation_stack.prod-watch-alexa-supercronic-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)           | resource    |
| [aws_cloudformation_stack.prod-watch-assets-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                          | resource    |
| [aws_cloudformation_stack.prod-watch-assets-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                     | resource    |
| [aws_cloudformation_stack.prod-watch-cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                             | resource    |
| [aws_cloudformation_stack.prod-watch-cplay-dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                     | resource    |
| [aws_cloudformation_stack.prod-watch-cplay-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                           | resource    |
| [aws_cloudformation_stack.prod-watch-cplay-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                      | resource    |
| [aws_cloudformation_stack.prod-watch-cplay-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                       | resource    |
| [aws_cloudformation_stack.prod-watch-cplay-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                            | resource    |
| [aws_cloudformation_stack.prod-watch-cropper-dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                   | resource    |
| [aws_cloudformation_stack.prod-watch-cropper-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                         | resource    |
| [aws_cloudformation_stack.prod-watch-cropper-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                    | resource    |
| [aws_cloudformation_stack.prod-watch-cropper-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                     | resource    |
| [aws_cloudformation_stack.prod-watch-cropper-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                          | resource    |
| [aws_cloudformation_stack.prod-watch-editorials-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                      | resource    |
| [aws_cloudformation_stack.prod-watch-editorials-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                 | resource    |
| [aws_cloudformation_stack.prod-watch-player-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                          | resource    |
| [aws_cloudformation_stack.prod-watch-player-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                     | resource    |
| [aws_cloudformation_stack.prod-watch-queues-dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                    | resource    |
| [aws_cloudformation_stack.prod-watch-queues-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                          | resource    |
| [aws_cloudformation_stack.prod-watch-queues-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                     | resource    |
| [aws_cloudformation_stack.prod-watch-queues-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                      | resource    |
| [aws_cloudformation_stack.prod-watch-queues-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                           | resource    |
| [aws_cloudformation_stack.prod-watch-webcenter-dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                 | resource    |
| [aws_cloudformation_stack.prod-watch-webcenter-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                       | resource    |
| [aws_cloudformation_stack.prod-watch-webcenter-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                  | resource    |
| [aws_cloudformation_stack.prod-watch-webcenter-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                   | resource    |
| [aws_cloudformation_stack.prod-watch-webcenter-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                        | resource    |
| [aws_cloudformation_stack.prod-watch-wp-avod-ingest-supercronic-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource    |
| [aws_cloudformation_stack.prod-watch-wp-avod-ingest-supercronic-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)  | resource    |
| [aws_cloudformation_stack.prod-watch-wp-avod-supercronic-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)        | resource    |
| [aws_cloudformation_stack.prod-watch-wp-avod-supercronic-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)         | resource    |
| [aws_cloudformation_stack.prod-watch-wp-dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                        | resource    |
| [aws_cloudformation_stack.prod-watch-wp-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                              | resource    |
| [aws_cloudformation_stack.prod-watch-wp-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                         | resource    |
| [aws_cloudformation_stack.prod-watch-wp-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                          | resource    |
| [aws_cloudformation_stack.prod-watch-wp-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                               | resource    |
| [aws_cloudformation_stack.prod-watch-wp-svod-ingest-supercronic-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource    |
| [aws_cloudformation_stack.prod-watch-wp-svod-ingest-supercronic-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)  | resource    |
| [aws_cloudformation_stack.prod-watch-wp-svod-supercronic-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)        | resource    |
| [aws_cloudformation_stack.prod-watch-wp-svod-supercronic-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)         | resource    |
| [aws_cloudformation_stack.prod-webcenter-cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                         | resource    |
| [aws_cloudformation_stack.qa-watch-alexa-cache-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                         | resource    |
| [aws_cloudformation_stack.qa-watch-alexa-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                             | resource    |
| [aws_cloudformation_stack.qa-watch-alexa-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                        | resource    |
| [aws_cloudformation_stack.qa-watch-alexa-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                         | resource    |
| [aws_cloudformation_stack.qa-watch-alexa-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                              | resource    |
| [aws_cloudformation_stack.qa-watch-alexa-supercronic-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)            | resource    |
| [aws_cloudformation_stack.qa-watch-alexa-supercronic-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)             | resource    |
| [aws_cloudformation_stack.qa-watch-assets-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                            | resource    |
| [aws_cloudformation_stack.qa-watch-assets-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                       | resource    |
| [aws_cloudformation_stack.qa-watch-cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                               | resource    |
| [aws_cloudformation_stack.qa-watch-cplay-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                             | resource    |
| [aws_cloudformation_stack.qa-watch-cplay-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                        | resource    |
| [aws_cloudformation_stack.qa-watch-cplay-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                         | resource    |
| [aws_cloudformation_stack.qa-watch-cplay-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                              | resource    |
| [aws_cloudformation_stack.qa-watch-cropper-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                           | resource    |
| [aws_cloudformation_stack.qa-watch-cropper-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                      | resource    |
| [aws_cloudformation_stack.qa-watch-cropper-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                       | resource    |
| [aws_cloudformation_stack.qa-watch-cropper-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                            | resource    |
| [aws_cloudformation_stack.qa-watch-editorials-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                        | resource    |
| [aws_cloudformation_stack.qa-watch-editorials-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                   | resource    |
| [aws_cloudformation_stack.qa-watch-player-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                            | resource    |
| [aws_cloudformation_stack.qa-watch-player-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                       | resource    |
| [aws_cloudformation_stack.qa-watch-queues-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                            | resource    |
| [aws_cloudformation_stack.qa-watch-queues-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                       | resource    |
| [aws_cloudformation_stack.qa-watch-queues-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                        | resource    |
| [aws_cloudformation_stack.qa-watch-queues-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                             | resource    |
| [aws_cloudformation_stack.qa-watch-webcenter-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                         | resource    |
| [aws_cloudformation_stack.qa-watch-webcenter-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                    | resource    |
| [aws_cloudformation_stack.qa-watch-webcenter-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                     | resource    |
| [aws_cloudformation_stack.qa-watch-webcenter-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                          | resource    |
| [aws_cloudformation_stack.qa-watch-wp-avod-ingest-supercronic-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)   | resource    |
| [aws_cloudformation_stack.qa-watch-wp-avod-ingest-supercronic-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)    | resource    |
| [aws_cloudformation_stack.qa-watch-wp-avod-supercronic-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)          | resource    |
| [aws_cloudformation_stack.qa-watch-wp-avod-supercronic-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)           | resource    |
| [aws_cloudformation_stack.qa-watch-wp-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                                | resource    |
| [aws_cloudformation_stack.qa-watch-wp-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                           | resource    |
| [aws_cloudformation_stack.qa-watch-wp-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                            | resource    |
| [aws_cloudformation_stack.qa-watch-wp-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                                 | resource    |
| [aws_cloudformation_stack.qa-watch-wp-svod-ingest-supercronic-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)   | resource    |
| [aws_cloudformation_stack.qa-watch-wp-svod-ingest-supercronic-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)    | resource    |
| [aws_cloudformation_stack.qa-watch-wp-svod-supercronic-pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)          | resource    |
| [aws_cloudformation_stack.qa-watch-wp-svod-supercronic-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)           | resource    |
| [aws_cloudformation_stack.qa-webcenter-cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                           | resource    |
| [terraform_remote_state.root](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state)                                            | data source |

## Inputs

| Name                                                                        | Description                                                                                     | Type     | Default          | Required |
| --------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | -------- | ---------------- | :------: |
| <a name="input_account_id"></a> [account_id](#input_account_id)             | AWS Account ID                                                                                  | `string` | `"433624884903"` |    no    |
| <a name="input_default_region"></a> [default_region](#input_default_region) | AWS region                                                                                      | `string` | `"us-east-1"`    |    no    |
| <a name="input_environment"></a> [environment](#input_environment)          | The environment that we're running this infrastructure for. e.g. dev, stage, prod, sandbox etc. | `string` | `"production"`   |    no    |
| <a name="input_namespace"></a> [namespace](#input_namespace)                | Namespace, which is our organization abbreviation: aen                                          | `string` | `"aetn"`         |    no    |
| <a name="input_stage"></a> [stage](#input_stage)                            | The Customer that we're running this infrastructure for. e.g. sanbox, etc.                      | `string` | `"production"`   |    no    |

## Outputs

No outputs.
