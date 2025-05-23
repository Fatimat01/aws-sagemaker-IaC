<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_policy.mlflow_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.test-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.mlflow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.priv](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.priv](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_s3_bucket.clarify](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.mlflow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.raw_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_sagemaker_app.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_app) | resource |
| [aws_sagemaker_domain.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_domain) | resource |
| [aws_sagemaker_mlflow_tracking_server.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_mlflow_tracking_server) | resource |
| [aws_sagemaker_user_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_user_profile) | resource |
| [aws_security_group.sm_studio](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.priv](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_iam_policy_document.mlflow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_role.sagemaker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | App name. this is the name of the JupyterLab app that will be created in the SageMaker Studio | `string` | `"jupyterlab"` | no |
| <a name="input_app_type"></a> [app\_type](#input\_app\_type) | App type. this is the type of the app that will be created in the SageMaker Studio | `string` | `"JupyterLab"` | no |
| <a name="input_code_repository_url"></a> [code\_repository\_url](#input\_code\_repository\_url) | A list of Git repositories that SageMaker AI automatically displays to users for cloning in the JupyterServer application | `string` | n/a | yes |
| <a name="input_create_user_profile"></a> [create\_user\_profile](#input\_create\_user\_profile) | Create a user profile | `bool` | `false` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name | `string` | `"mlops"` | no |
| <a name="input_sagemaker_role_name"></a> [sagemaker\_role\_name](#input\_sagemaker\_role\_name) | SageMaker role name | `string` | `"SM-Admin-Role"` | no |
| <a name="input_user_profile_name"></a> [user\_profile\_name](#input\_user\_profile\_name) | User profile name | `string` | `"dev-user"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sagemaker_domain_arn"></a> [sagemaker\_domain\_arn](#output\_sagemaker\_domain\_arn) | The Amazon Resource Name (ARN) assigned by AWS to this Domain. |
| <a name="output_sagemaker_domain_id"></a> [sagemaker\_domain\_id](#output\_sagemaker\_domain\_id) | The ID of the Domain. |
| <a name="output_sagemaker_domain_url"></a> [sagemaker\_domain\_url](#output\_sagemaker\_domain\_url) | The domain's URL. |
| <a name="output_sagemaker_user_profile_arn"></a> [sagemaker\_user\_profile\_arn](#output\_sagemaker\_user\_profile\_arn) | The user profile Amazon Resource Name (ARN). |
| <a name="output_sagemaker_user_profile_id"></a> [sagemaker\_user\_profile\_id](#output\_sagemaker\_user\_profile\_id) | The user profile Amazon Resource Name (ARN). |
<!-- END_TF_DOCS -->