[
  {
    "name": "myapp",
    "image": "${app_image}:latest",
    "cpu": ${fargate_cpu},
    "memory": ${fargate_memory},
    "networkMode": "awsvpc",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
          "awslogs-group": "es",
          "awslogs-region": "${region}",
          "awslogs-stream-prefix": "awslogs-${app_image}"
      }
            },
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ]
  }
]