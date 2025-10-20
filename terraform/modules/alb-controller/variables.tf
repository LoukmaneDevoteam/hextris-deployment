variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_oidc_url" {
  description = "EKS cluster OIDC URL"
  type        = string
}

variable "cluster_oidc_arn" {
  description = "EKS cluster OIDC ARN"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}