#  raw_data_bucket – store original and preprocessed data
resource "aws_s3_bucket" "raw_data" {
  bucket = "${var.project_name}-raw-data"

  tags = {
    Project = var.project_name
  }
}


# model_artifact_bucket mlflow backend – store trained models and inference outputs

resource "aws_s3_bucket" "mlflow" {
  bucket = "${var.project_name}-mlflow"
  tags = {
    Project = var.project_name
  }
}
# clarify_output_bucket – store SageMaker Clarify bias/explainability results

resource "aws_s3_bucket" "clarify" {
  bucket = "${var.project_name}-clarify-output"
  tags = {
    Project = var.project_name
  }
}

## studio s3