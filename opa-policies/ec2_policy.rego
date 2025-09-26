package terraform.ec2

# Required tags for all AWS EC2 resources
required_tags := {"Environment", "Department"}

deny[msg] {
    input.resource_changes[_].type == "aws_instance"

    # get the current resource object
    resource := input.resource_changes[_]

    # iterate over required tags
    some t
    t := required_tags[_]

    # check if the tag is missing
    not resource.change.after.tags[t]

    msg = sprintf("EC2 '%s' is missing required tag: %s", [resource.address, t])
}