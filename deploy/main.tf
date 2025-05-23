provider "aws" {
  region = "us-east-1"
}


module "sagemaker" {
    source = "../"
    project_name = "sagemaker-mlops"
    code_repository_url = "https://github.com/Fatimat01/mlflow-cnn-mlops.git"
    user_profile_name = "dev-user"
    app_name = "jupyterlab"
    app_type = "JupyterLab"
    sagemaker_role_name = "SM-Admin-Role"
  
}