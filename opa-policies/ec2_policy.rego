package terraform.ec2

deny[msg] {
    resource := input.resource_changes[_]
    resource.type == "aws_instance"
    "update" in resource.change.actions

    before := resource.change.before.instance_type
    after := resource.change.after.instance_type

    before != after
    msg := sprintf("EC2 %s instance type is being changed from %s to %s", [resource.address, before, after])
}