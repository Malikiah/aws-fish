region = "us-west-1"
es-version = "6.2"
es-domain = "es-fishtech"
es-instance-type = "m5.xlarge.elasticsearch"

ebs-availability-zone = "us-west-1b"
es-ebs-enabled = true
es-ebs-type = "gp2"
es-ebs-size = 20

app_count = 1

app_image = "nginx"
app_port = 80
fargate_cpu = 1024
fargate_memory = 2048

az_count = 2
ecs_task_execution_role_name = "fishtech"