# Define variable for S3
variable "env" {
  default     = "ecr"
  type        = string
  description = "Deployment Environment"
}

# Define the name of ECR Repository here
variable "ecr_repo_name" {
  default     = ["cloud", "sun"]
  type        = list(string)
  description = "Amazon ECR Repository"
}