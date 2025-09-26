package terraform.ec2

# Define required tags
required_tags := {"Environment", "Department"}

# Deny rule triggered if any required tag is missing
deny[msg] {
    input.resource_type == "aws_instance"          # Only check EC2 instances
    some tag_name                                  # Use unique variable name
    tag_name := required_tags[_]
    not input.tags[tag_name]                        # Missing tag
    msg = sprintf("EC2 instance '%s' is missing required tag: %s", [input.resource_name, tag_name])
}
