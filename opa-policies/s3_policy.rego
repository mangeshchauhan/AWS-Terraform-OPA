package terraform.s3

deny[msg] {
  input.resource_type == "aws_s3_bucket"
  not input.encrypted
  msg = sprintf("S3 bucket %s must have encryption enabled.", [input.name])
}
