variable "project_name" {
  description = "Project name"
  type        = string
  default     = "mlops" 
}

# variable "vpc_id" {
#   description = "VPC ID"
#   type        = string
# }


variable "code_repository_url" {
  description = "A list of Git repositories that SageMaker AI automatically displays to users for cloning in the JupyterServer application"
  type        = string
}

variable "create_user_profile" {
  description = "Create a user profile"
  type        = bool
  default     = false
}

variable "user_profile_name" {
  description = "User profile name"
  type        = string
  default     = "dev-user"
  
}

variable "app_name" {
  description = "App name. this is the name of the JupyterLab app that will be created in the SageMaker Studio"
  type        = string
  default     = "jupyterlab"
  
}

variable "app_type" {
  description = "App type. this is the type of the app that will be created in the SageMaker Studio"
  type        = string
  default     = "JupyterLab"
  
}

variable "sagemaker_role_name" {
  description = "SageMaker role name"
  type        = string
  default = "SM-Admin-Role"
  
}