resource "aws_ecs_cluster" "cluster" {
  name = "asfer-cluster"
}

resource "aws_ecs_task_definition" "backend_1_task" {
  family                   = "asfer-1-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = "asfer-1-container"
      image     = "nginx"
      essential = true
      cpu       = 256
      memory    = 512
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      command = ["sh", "-c", "echo '<h1>Backend 1 Server says HELLO</h1>' > /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"]
    }
  ])
}

resource "aws_ecs_task_definition" "backend_2_task" {
  family                   = "asfer-2-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = "asfer-2-container"
      image     = "nginx"
      essential = true
      cpu       = 256
      memory    = 512
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      command = ["sh", "-c", "echo '<h1>Backend 2 Server Working</h1>' > /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"]
    }
  ])
}

resource "aws_ecs_service" "backend_1_service" {
  name            = "asfer-backend-1-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.backend_1_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = var.subnets
    security_groups  = [var.security_group]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = "asfer-1-container"
    container_port   = 80
  }
  depends_on = [var.lb_listener_arn]
}

resource "aws_ecs_service" "backend_2_service" {
  name            = "asfer-backend-2-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.backend_2_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = var.subnets
    security_groups  = [var.security_group]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = "asfer-2-container"
    container_port   = 80
  }
  depends_on = [var.lb_listener_arn]
}
