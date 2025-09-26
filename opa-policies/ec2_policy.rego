package terraform.ec2

# List of required tags
required_tags := {"Environment", "Department"}

# Deny if any required tag is missing
deny[msg] {
    input.resource_type == "aws_instance"
    
    # iterate over required tags
    some rtag
    rtag := required_tags[_]

    # check if input tags are missing
    not input.tags[rtag]

    msg = sprintf("EC2 instance '%s' is missing required tag: %s", [input.resource_name, rtag])
}