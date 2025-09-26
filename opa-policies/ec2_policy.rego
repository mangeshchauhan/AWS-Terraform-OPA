package terraform.ec2

deny[msg] {
    required_tags := {"Name", "Environment", "Department"}
    resource := input.resource_changes[_]
    resource.type == "aws_instance"
    
    tag := required_tags[_]
    not resource.change.after.tags[tag]
    
    msg = sprintf("EC2 %s is missing required tag: %s", [resource.address, tag])
}