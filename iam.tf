## create MLFLOW IAM role

resource "aws_iam_role" "mlflow" {
  name               = "${var.project_name}-mlflow-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.mlflow.json
}

data "aws_iam_policy_document" "mlflow" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "mlflow_policy" {
  name        = "${var.project_name}-mlflow-policy"
  description = "Policy for MLflow Tracking Server"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
                "s3:Get*",
                "s3:Put*",
                "s3:List*",
                "sagemaker:AddTags",
                "sagemaker:CreateModelPackageGroup",
                "sagemaker:CreateModelPackage",
                "sagemaker:UpdateModelPackage",
                "sagemaker:DescribeModelPackageGroup"
            ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "mlflow-policy-attachment"
  roles      = [aws_iam_role.mlflow.name]
  policy_arn = aws_iam_policy.mlflow_policy.arn
}
# # Domain Execution role  IAM role that Amazon SageMaker Unified Studio
# # Domain Service role This is a service role for domain level actions performed by Amazon SageMaker Unified Studio.
# # 
# arn:aws:iam::aws:policy/service-role/SageMakerStudioDomainExecutionRolePolicy
# arn:aws:iam::aws:policy/service-role/SageMakerStudioDomainServiceRolePolicy
# {
#   "Version": "2012-10-17",
#   "Statement": [
#       {
#           "Effect": "Allow",
#           "Principal": {
#               "Service": "datazone.amazonaws.com"
#           },
#           "Action": [
#               "sts:AssumeRole",
#               "sts:TagSession",
#               "sts:SetContext"
#           ],
#           "Condition": {
#               "StringEquals": {
#                   "aws:SourceAccount": "{{source_account_id}}"
#               },
#               "ForAllValues:StringLike": {
#                   "aws:TagKeys": "datazone*"
#               }
#           }
#       }
#   ]
# }
# data "aws_caller_identity" "current" {}

# data "aws_region" "current" {}
# ##################################################################################################
# # Roles & Policies
# ##################################################################################################


# resource "aws_iam_role" "execution_role" {
#   name               = "${var.project_name}-execution-role"
#   path               = "/"
#   assume_role_policy = data.aws_iam_policy_document.execution_role.json
# }

# data "aws_iam_policy_document" "execution_role" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["sagemaker.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role_policy_attachment" "aws_sagemaker_full_access" {
#   role       = aws_iam_role.execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
# }


# # resource "aws_iam_policy" "codecommit_policy" {
# #   name        = "${local.prefix}-codecommit-policy"
# #   description = "${local.prefix} policy for SM Studio codecommit access"

# #   policy = <<EOF
# # {
# #   "Version": "2012-10-17",
# #   "Statement": [
# #     {
# #       "Action": [
# #         "codecommit:*"
# #       ],
# #       "Effect": "Allow",
# #       "Resource": "arn:aws:codecommit:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${local.prefix}*"
# #     }
# #   ]
# # }
# # EOF
# # }




# resource "aws_iam_role_policy_attachment" "aws_sagemaker_s3_full_access" {
#   role       = aws_iam_role.execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
# }

# resource "aws_iam_policy" "eventbridge_policy" {
#   name        = "${var.project_name}-eventbridge-policy"
#   description = "EventBridge Policy for SM Execution Role"

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "events:*"
#       ],
#       "Effect": "Allow",
#       "Resource": "arn:aws:events:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:rule/${var.project_name}*"
#     }
#   ]
# }
# EOF
# }


# resource "aws_iam_role_policy_attachment" "attach_eventbridge_policy" {
#   role       = aws_iam_role.execution_role.name
#   policy_arn = aws_iam_policy.eventbridge_policy.arn
# }

# resource "aws_iam_policy" "kms_policy" {
#   name        = "${var.project_name}-kms-policy"
#   description = "kms_policy for SM Studio"

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "kms:*"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy_attachment" "attach" {
#   role       = aws_iam_role.execution_role.name
#   policy_arn = aws_iam_policy.kms_policy.arn
# }

# resource "aws_iam_policy" "sagemaker_policy" {
#   name        = "${var.project_name}-iam-policy"
#   description = "Policy for SM Studio"

#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "RoleActions",
#             "Effect": "Allow",
#             "Action": [
#                 "iam:CreateRole",
#                 "iam:GetRole",
#                 "iam:ListRolePolicies",
#                 "iam:ListAttachedRolePolicies",
#                 "iam:ListInstanceProfilesForRole",
#                 "iam:DeleteRole",
#                 "iam:PutRolePolicy",
#                 "iam:GetRolePolicy",
#                 "iam:DeleteRolePolicy",
#                 "iam:AttachRolePolicy"
#             ],
#             "Resource":  "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.project_name}*"
#         },
#         {
#             "Sid": "PolicyActions",
#             "Effect": "Allow",
#             "Action": [
#                 "iam:CreatePolicy",
#                 "iam:GetPolicy",
#                 "iam:ListRolePolicies",
#                 "iam:ListAttachedRolePolicies",
#                 "iam:PutRolePolicy",
#                 "iam:GetRolePolicy",
#                 "iam:DeleteRolePolicy",
#                 "iam:AttachRolePolicy",
#                 "iam:DetachRolePolicy"
#             ],
#             "Resource":  [
#               "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/${var.project_name}*"
#             ]
#         },
#         {
#             "Sid": "DetachManagedPolicies",
#             "Effect": "Allow",
#             "Action": [
#                 "iam:DeleteRolePolicy",
#                 "iam:DetachRolePolicy"
#             ],
#             "Resource":  [
#               "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.project_name}*"
#             ]
#         },
#         {
#             "Sid": "PassRoleToSMPipelines",
#             "Effect": "Allow",
#             "Action": [
#                 "iam:PassRole"
#             ],
#             "Resource": [
#               "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.project_name}*"
#             ]
#         },
#         {
#             "Sid": "TerraformAccessPolicies",
#             "Effect": "Allow",
#             "Action": [
#                 "iam:CreatePolicy",
#                 "iam:GetPolicy",
#                 "iam:GetPolicyVersion",
#                 "iam:ListPolicyVersions",
#                 "iam:CreatePolicyVersion",
#                 "iam:DeletePolicy",
#                 "iam:DeletePolicyVersion"
#             ],
#             "Resource": [
#               "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/terraform-*"
#             ]
#         }
#     ]
# }
# EOF
# }

# resource "aws_iam_role_policy_attachment" "iam_create_role_attach" {
#   role       = aws_iam_role.execution_role.name
#   policy_arn = aws_iam_policy.iam_create_role.arn
# }

# ###############
# # execution role policy
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Action": [
#                 "s3:ListBucket"
#             ],
#             "Effect": "Allow",
#             "Resource": [
#                 "arn:aws:s3:::SageMaker"
#             ]
#         },
#         {
#             "Action": [
#                 "s3:GetObject",
#                 "s3:PutObject",
#                 "s3:DeleteObject"
#             ],
#             "Effect": "Allow",
#             "Resource": [
#                 "arn:aws:s3:::SageMaker/*"
#             ]
#         }
#     ]
# }
# AmazonSageMakerCanvasAIServicesAccess
# AmazonSageMakerCanvasDataPrepFullAccess
# AmazonSageMakerCanvasFullAccess
# AmazonSageMakerCanvasSMDataScienceAssistantAccess
# AmazonSageMakerFullAccess

# trust
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Principal": {
#                 "Service": "sagemaker.amazonaws.com"
#             },
#             "Action": "sts:AssumeRole"
#         }
#     ]
# }

# CanvasEMRSExecutionAccess role
# AmazonSageMakerCanvasEMRServerlessExecutionRolePolicy