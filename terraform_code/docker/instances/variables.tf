# Instance type
variable "instance_type" {
  default = {
    "prod"    = "t3.medium"
    "test"    = "t3.micro"
    "staging" = "t2.micro"
    "dev"     = "t2.micro"
    "docker"  = "t2.micro"
  }
  description = "Type of the instance"
  type        = map(string)
}

# Variable to signal the current environment 
variable "env" {
  default     = "prod"
  type        = string
  description = "Deployment Environment"
}

variable "sg_port_number" {
  default     = ["22", "80", "30000", "30001"]
  type        = list(string)
  description = "Security Group ports for ssh and web access"
}

# CIDR Range to everywhere
variable "cidr_RG" {
  type        = string
  default     = "0.0.0.0/0"
  description = "Public IP of my Cloud 9 station to be opened in bastion ingress"
}
