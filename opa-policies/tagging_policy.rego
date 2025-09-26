package terraform.tags

deny[msg] {
  required_tags := {"Department", "Environment"}
  some i
  tag := required_tags[i]
  not input.tags[tag]
  msg = sprintf("Resource %s is missing required tag: %s", [input.resource_name, tag])
}