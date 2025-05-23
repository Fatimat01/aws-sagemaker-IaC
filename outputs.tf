output "sagemaker_domain_id" {
  description = "The ID of the Domain."
  value       = element(concat(aws_sagemaker_domain.this.*.id, [""]), 0)
}

output "sagemaker_domain_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this Domain."
  value       = element(concat(aws_sagemaker_domain.this.*.arn, [""]), 0)
}

output "sagemaker_domain_url" {
  description = "The domain's URL."
  value       = element(concat(aws_sagemaker_domain.this.*.url, [""]), 0)
}

output "sagemaker_user_profile_id" {
  description = "The user profile Amazon Resource Name (ARN)."
  value       = element(concat(aws_sagemaker_user_profile.this.*.id, [""]), 0)
}

output "sagemaker_user_profile_arn" {
  description = "The user profile Amazon Resource Name (ARN)."
  value       = element(concat(aws_sagemaker_user_profile.this.*.arn, [""]), 0)
}