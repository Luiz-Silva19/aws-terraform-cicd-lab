
terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "lab-dev-141553305125-us-east-1-an"
    key          = "s3-lab/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

locals {
  bucket_name = "aws-devops-${data.aws_caller_identity.current.account_id}-${var.aws_region}"
}

resource "aws_s3_bucket" "lab" {
  bucket = local.bucket_name

  tags = {
    Name        = "aws-terraform-cicd-lab"
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "lab" {
  bucket = aws_s3_bucket.lab.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "lab" {
  bucket = aws_s3_bucket.lab.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "lab" {
  bucket = aws_s3_bucket.lab.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
