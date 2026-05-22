variable "vpc_id" {
  type = string
  description = "The ID of the VPC"
}

variable "private_subnet_ids" {
  type = list(string)
  description = "List of private subnet IDs for EKS worker nodes"
}
