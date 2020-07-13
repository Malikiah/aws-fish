resource "aws_elasticsearch_domain" "fishtech" {
  domain_name = var.es-domain
  elasticsearch_version = var.es-version

  cluster_config {
    instance_count = var.es-count
    instance_type = var.es-instance-type
  }

  ebs_options {
    ebs_enabled = var.es-ebs-enabled
    volume_type = var.es-ebs-type
    volume_size = var.es-ebs-size
  }

  vpc_options {
    subnet_ids = [ aws_subnet.private[0].id ]
    security_group_ids = ["${aws_security_group.ecs_tasks.id}"]
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

   log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.es.arn
    log_type                 = "INDEX_SLOW_LOGS"
  }

  depends_on = [
    aws_security_group.ecs_tasks,
    aws_subnet.private,
    aws_iam_service_linked_role.es,

  ]
}

resource "aws_cloudwatch_log_group" "es" {
  name = "es"
}

resource "aws_cloudwatch_log_resource_policy" "es" {
  policy_name = "es"

  policy_document = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": [
        "logs:PutLogEvents",
        "logs:PutLogEventsBatch",
        "logs:CreateLogStream"
      ],
      "Resource": "arn:aws:logs:*"
    }
  ]
}
CONFIG
}

data "aws_caller_identity" "current" {}