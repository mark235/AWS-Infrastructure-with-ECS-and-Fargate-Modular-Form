provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "iam" {
  source = "./modules/iam"
}

module "load_balancer" {
  source          = "./modules/load_balancer"
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.subnet_ids
  security_groups = [module.security_group.security_group_id]
}

module "ecs" {
  source                 = "./modules/ecs"
  vpc_id                 = module.vpc.vpc_id
  subnets                = module.vpc.subnet_ids
  security_group         = module.security_group.security_group_id
  ecs_execution_role_arn = module.iam.ecs_execution_role_arn
  ecs_task_role_arn      = module.iam.ecs_task_role_arn
  lb_target_group_arn    = module.load_balancer.target_group_arn
  lb_listener_arn        = module.load_balancer.listener_arn
}

