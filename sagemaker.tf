data "aws_iam_role" "sagemaker" {
  name = var.sagemaker_role_name
}

resource "aws_sagemaker_domain" "this" {
  domain_name = var.project_name
  auth_mode   = "IAM"
  vpc_id      = aws_vpc.this.id
  subnet_ids  = [aws_subnet.priv[0].id, aws_subnet.priv[1].id]


  default_space_settings {
    execution_role = data.aws_iam_role.sagemaker.arn
  }

  default_user_settings {
    execution_role = data.aws_iam_role.sagemaker.arn

    canvas_app_settings {
      model_register_settings {
        status                   = "ENABLED"
      }
      direct_deploy_settings {
        status                   = "ENABLED"
      }
    }

    jupyter_lab_app_settings {
      lifecycle_config_arns = []

      app_lifecycle_management {
        idle_settings {
          idle_timeout_in_minutes = 60
          lifecycle_management  = "ENABLED"
          max_idle_timeout_in_minutes = 60
          min_idle_timeout_in_minutes = 60
          }
      }
      code_repository {
        repository_url = var.code_repository_url
        
      }
    }
  }

  domain_settings {
    security_group_ids = [aws_security_group.sm_studio.id]
    }
}


### sagemaker user profile 
resource "aws_sagemaker_user_profile" "this" {
  domain_id         = aws_sagemaker_domain.this.id
  user_profile_name = var.user_profile_name
  depends_on = [ aws_sagemaker_domain.this ]

  user_settings {
    execution_role  = data.aws_iam_role.sagemaker.arn
    security_groups = []

    canvas_app_settings {
      model_register_settings {
        status                   = "ENABLED"
      }
      direct_deploy_settings {
        status                   = "ENABLED"
      }
    }

    jupyter_lab_app_settings {
      lifecycle_config_arns = []

      app_lifecycle_management {
        idle_settings {
          idle_timeout_in_minutes = 60
          lifecycle_management  = "ENABLED"
          }
      }
      code_repository {
        repository_url = var.code_repository_url
        
      }
  }

  }
}

# enable addtional apps for user profile
resource "aws_sagemaker_app" "app" {
  domain_id         = aws_sagemaker_domain.this.id
  user_profile_name = aws_sagemaker_user_profile.this.user_profile_name
  app_name          = var.app_name
  app_type          = var.app_type
}

## create MLflow Tracking Server
resource "aws_sagemaker_mlflow_tracking_server" "this" {
  tracking_server_name = "${var.project_name}-mlflow"
  role_arn             = aws_iam_role.mlflow.arn
  artifact_store_uri   = "s3://${aws_s3_bucket.mlflow.bucket}/path"
  depends_on = [ aws_s3_bucket.mlflow, aws_sagemaker_domain.this ]
  tags = {
    Name = "${var.project_name}-mlflow"
  }
}



######## user profile
# use same execution role as domain
# efs for mouunting
# app config - enable docker, sagemaker studio, jupyter lab, 
# sm studio classic with s3 for sharing notebook, enable project template