provider "aws" {
  version = "~> 2.0"
  region  = var.region
}
variable "region" {
  description = "AWS region"
  default     = "us-east-2"
}
variable "repository_name" {
  description = "GitHub repository name"
  default     = "CI-CD-Demo"
}
variable "repository_branch" {
  description = "Repository branch to connect to"
  default     = "main"
}

variable "repository_owner" {
  description = "GitHub repository owner"
  default     = "Si-max"
}
variable "build_bucket_name" {
  description = "S3 Bucket to deploy to"
  default     = "CI-CD-Demo"
}

variable "env" {
  description = "Depolyment environment"
  default     = "dev"
}