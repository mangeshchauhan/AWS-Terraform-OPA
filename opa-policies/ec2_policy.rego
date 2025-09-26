package terraform.ec2

deny[msg] {
    required_tags := {"Name", "Environment", "Department"}
    resource := input.resource_changes[_]
    resource.type == "aws_instance"

    # Check tags
    tag := required_tags[_]
    not resource.change.after.tags[tag]
    msg := sprintf("EC2 %s is missing required tag: %s", [resource.address, tag])
}

deny[msg] {
    resource := input.resource_changes[_]
    resource.type == "aws_instance"

    # Deny if instance type is changing
    resource.change.before.instance_type != resource.change.after.instance_type
    msg := sprintf("EC2 %s instance type is being changed from %s to %s", [resource.address, resource.change.before.instance_type, resource.change.after.instance_type])
}
