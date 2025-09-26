output "security_groups_id" {
  description = "Security Group ID for EC2 and RDS"
  value       = aws_security_group.main.id
}