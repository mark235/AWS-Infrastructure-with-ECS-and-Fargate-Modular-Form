variable "vpc_id" {
  description = "The ID of the VPC where the ECS cluster and services will be created"
  type        = string
}

variable "subnets" {
  description = "The IDs of the subnets where the ECS services will be created"
  type        = list(string)
}

variable "security_group" {
  description = "The ID of the security group to associate with the ECS services"
  type        = string
}

variable "ecs_execution_role_arn" {
  description = "The ARN of the IAM role that ECS tasks will use for execution"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "The ARN of the IAM role that ECS tasks will use"
  type        = string
}

variable "lb_target_group_arn" {
  description = "The ARN of the load balancer target group to associate with the ECS services"
  type        = string
}

variable "lb_listener_arn" {
  description = "The ARN of the load balancer listener"
  type        = string
}