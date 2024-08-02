variable "vpc_id" {
  description = "The ID of the VPC where the load balancer will be created"
  type        = string
}

variable "subnets" {
  description = "The IDs of the subnets where the load balancer will be created"
  type        = list(string)
}

variable "security_groups" {
  description = "The IDs of the security groups to associate with the load balancer"
  type        = list(string)
}
