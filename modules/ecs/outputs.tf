output "ecs_cluster_id" {
  value = aws_ecs_cluster.cluster.id
}

output "backend_1_service_id" {
  value = aws_ecs_service.backend_1_service.id
}

output "backend_2_service_id" {
  value = aws_ecs_service.backend_2_service.id
}
