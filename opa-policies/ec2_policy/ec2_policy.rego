package terraform.ec2

deny[msg] {
  input.resource_type == "aws_instance"
  input.environment == "dev"
  not input.instance_type == "t2.micro"
  msg = sprintf("EC2 instance type %s is not allowed in dev. Use t2.micro.", [input.instance_type])
}
