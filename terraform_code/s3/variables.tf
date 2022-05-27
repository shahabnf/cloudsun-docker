# Define variable for S3
variable "env" {
  default     = "ecr"
  type        = string
  description = "Deployment Environment"
}
