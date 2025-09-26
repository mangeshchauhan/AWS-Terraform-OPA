package terraform.tags

deny[msg] {
  required_tags := {"Department", "Environment"}
  some tag
  tag := required_tags[_]
  not input.resource_changes[_].change.after.tags[tag]
  msg = sprintf("Resource %s is missing required tag: %s", [input.resource_changes[_].address, tag])
}
