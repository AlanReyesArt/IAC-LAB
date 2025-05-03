
variable "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-2"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Sistema de reservas en hotel"
  type        = string
  default     = "hotel-reservations"
}

variable "lambda_timeout" {
  description = "Tiempo máximo de ejecución para la función Lambda (segundos)"
  type        = number
  default     = 10
}

variable "lambda_memory_size" {
  description = "Memoria asignada a la función Lambda (MB)"
  type        = number
  default     = 256
}

variable "lambda_runtime" {
  description = "Runtime de la función Lambda"
  type        = string
  default     = "nodejs16.x"
}

variable "dynamodb_billing_mode" {
  description = "Modo de facturación para DynamoDB"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "dynamodb_read_capacity" {
  description = "Capacidad de lectura para DynamoDB (solo si billing_mode es PROVISIONED)"
  type        = number
  default     = 5
}

variable "dynamodb_write_capacity" {
  description = "Capacidad de escritura para DynamoDB (solo si billing_mode es PROVISIONED)"
  type        = number
  default     = 5
}