# Default tags
output "default_tags" {
  value = {
    "Owner"      = "Shahab"
    "App"        = "Web"
    "Project"    = "CLO835"
    "Assignment" = "Assignment1"
  }
}

# Prefix to identify resources
output "prefix" {
  value     = "docker"
}