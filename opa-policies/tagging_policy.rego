package terraform.tags

deny[msg] {
  required_tags := {"Department", "Environment"}
  some i
  tag_name := required_tags[i]

  # Check if the tag is missing in the resource
  not input.resource_changes[_].change.after.tags[tag_name]

  msg = sprintf(
    "Resource %s is missing required tag: %s",
    [input.resource_changes[_].address, tag_name]
  )
}
