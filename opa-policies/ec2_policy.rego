package terraform.ec2

# Deny if required tags are missing
deny[msg] {
    required_tags := {"Name", "Environment", "Department"}
    resource := input.resource_changes[_]
    resource.type == "aws_instance"
    not contains(resource.change.actions, "delete")

    tag := required_tags[_]
    not resource.change.after.tags[tag]
    msg := sprintf("EC2 %s is missing required tag: %s", [resource.address, tag])
}

# Deny if instance type is being changed
deny[msg] {
    resource := input.resource_changes[_]
    resource.type == "aws_instance"
    contains(resource.change.actions, "update")

    before := resource.change.before.instance_type
    after := resource.change.after.instance_type

    before != after
    msg := sprintf("EC2 %s instance type is being changed from %s to %s", [resource.address, before, after])
}

# Deny if instance is being replaced
deny[msg] {
    resource := input.resource_changes[_]
    resource.type == "aws_instance"
    contains(resource.change.actions, "replace")

    before := resource.change.before.instance_type
    after := resource.change.after.instance_type

    before != after
    msg := sprintf("EC2 %s is being replaced: instance type %s -> %s", [resource.address, before, after])
}

# Helper function
contains(arr, val) {
    some i
    arr[i] == val
}