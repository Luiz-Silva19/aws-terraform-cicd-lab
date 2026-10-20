
output "bucket_name" {
  description = "Nome do bucket criado"
  value       = aws_s3_bucket.lab.bucket
}

output "bucket_arn" {
  description = "ARN do bucket criado"
  value       = aws_s3_bucket.lab.arn
}

output "aws_account_id" {
  description = "ID da conta AWS"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  description = "Região AWS utilizada"
  value       = var.aws_region
}
