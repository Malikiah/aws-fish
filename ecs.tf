resource "aws_ecs_cluster" "main" {
  name = "ecs-cluster"
}

data "template_file" "app" {
  template = file("./templates/app-service.json.tpl")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    region     = var.region
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.app.rendered
}

resource "aws_ecs_service" "main" {
  name            = "myapp-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "myapp"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}

// resource "aws_ecs_cluster" "fishtech" {
//   name = "fishtech-cluster"
// }


// resource "aws_ecs_service" "nginx" {
//   name            = "nginx"
//   cluster         = aws_ecs_cluster.fishtech.id
//   task_definition = aws_ecs_task_definition.nginx.arn
//   desired_count   = 3
//   // iam_role        = "${aws_iam_role.foo.arn}"
//   // depends_on      = ["aws_iam_role_policy.foo"]

//   ordered_placement_strategy {
//     type  = "binpack"
//     field = "cpu"
//   }
  
//   depends_on = [
//       aws_ecs_cluster.fishtech,
//       aws_ecs_task_definition.nginx
//   ]
// }


// resource "aws_ecs_task_definition" "nginx" {
//   family                = "service"
//   container_definitions = file("task-definitions/nginx-service.json")

// }