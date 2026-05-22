variable "vpc_id" {
  type = string
  description = "The ID of the VPC"
}

variable "private_subnet_id" {
  type = string
  description = "The ID of the private subnet to deploy Jenkins"
}
