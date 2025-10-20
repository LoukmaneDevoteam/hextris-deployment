output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_ca_certificate" {
  description = "EKS cluster CA certificate"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "cluster_oidc_url" {
  description = "EKS cluster OIDC URL"
  value       = aws_iam_openid_connect_provider.eks.url
}

output "cluster_oidc_arn" {
  description = "EKS cluster OIDC ARN"
  value       = aws_iam_openid_connect_provider.eks.arn
}

output "cluster_auth_token" {
  description = "EKS cluster auth token"
  value       = data.aws_eks_cluster_auth.main.token
  sensitive   = true
}