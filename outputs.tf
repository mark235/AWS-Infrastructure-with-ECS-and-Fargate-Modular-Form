output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "security_group_id" {
  value = module.security_group.security_group_id
}

output "ecs_cluster_id" {
  value = module.ecs.ecs_cluster_id
}

output "backend_1_service_id" {
  value = module.ecs.backend_1_service_id
}

output "backend_2_service_id" {
  value = module.ecs.backend_2_service_id
}

output "lb_arn" {
  value = module.load_balancer.lb_arn
}

output "lb_dns_name" {
  value = module.load_balancer.lb_dns_name
}

output "target_group_arn_backend" {
  value = module.load_balancer.target_group_arn
}
