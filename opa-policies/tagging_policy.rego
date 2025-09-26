package terraform.tags

deny[msg] {
  required_tags := {"Department", "Environment"}
  some i
  tag_name := required_tags[i]

  # Iterate over all resources in the plan
  some j
  resource := input.resource_changes[j]

  # Check if the tag is missing in the resource after changes
  not resource.change.after.tags[tag_name]

  msg = sprintf(
    "Resource %s is missing required tag: %s",
    [resource.address, tag_name]
  )
}