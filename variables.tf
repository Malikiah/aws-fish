variable "region" {
  type = string
  description = ""
  default = ""
}

variable "az_count" {
  default = 0
}

variable "app_count" {
  type = number
  description = ""
  default = 0
}

variable "ecs_task_execution_role_name" {
  type = string
  description = ""
  default = ""
}

variable "es-version"{
  type = string
  description = ""
  default = ""
}

variable "es-count"{
  type = number
  description = ""
  default = 1
}

variable "es-domain" {
  type = string
  description = ""
  default = ""
}

variable "es-instance-type" {
  type = string
  description = ""
  default = ""
}

variable "ebs-availability-zone" {
  type = string
  description = ""
  default = ""
}

variable "es-ebs-enabled" {
  type = bool
  description = ""
  default = false
}

variable "es-ebs-type" {
  type = string
  description = ""
  default = ""
}

variable "es-ebs-size" {
  type = string
  description = ""
  default = ""
}

variable "es-ebs-encryption" {
  type = bool
  description = ""
  default = false
}

variable "app_image" {
  type = string
  description = ""
  default = ""
}

variable "app_port" {
  type = number
  description = ""
  default = 80
}

variable "fargate_cpu" {
  type = number
  description = ""
  default = 0
}

variable "fargate_memory" {
  type = number
  description = ""
  default = 0
}