output "alb_controller_role_arn" {
  description = "IAM role ARN for ALB controller"
  value       = aws_iam_role.alb_controller.arn
}