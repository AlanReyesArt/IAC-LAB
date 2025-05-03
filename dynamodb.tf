
resource "aws_dynamodb_table" "reservations" {
  name           = "${var.project_name}-${var.environment}-reservations"
  billing_mode   = var.dynamodb_billing_mode
 
  read_capacity  = var.dynamodb_billing_mode == "PROVISIONED" ? var.dynamodb_read_capacity : null
  write_capacity = var.dynamodb_billing_mode == "PROVISIONED" ? var.dynamodb_write_capacity : null
  
  hash_key       = "reservation_id"
  range_key      = "email"
  
  attribute {
    name = "reservation_id"
    type = "S"
  }
  
  attribute {
    name = "email"
    type = "S"
  }
  
  attribute {
    name = "check_in_date"
    type = "S"
  }
  
  global_secondary_index {
    name               = "EmailIndex"
    hash_key           = "email"
    projection_type    = "ALL"
    read_capacity      = var.dynamodb_billing_mode == "PROVISIONED" ? var.dynamodb_read_capacity : null
    write_capacity     = var.dynamodb_billing_mode == "PROVISIONED" ? var.dynamodb_write_capacity : null
  }
  
  global_secondary_index {
    name               = "CheckInDateIndex"
    hash_key           = "check_in_date"
    projection_type    = "ALL"
    read_capacity      = var.dynamodb_billing_mode == "PROVISIONED" ? var.dynamodb_read_capacity : null
    write_capacity     = var.dynamodb_billing_mode == "PROVISIONED" ? var.dynamodb_write_capacity : null
  }
  
  point_in_time_recovery {
    enabled = true
  }
  
  tags = local.common_tags
}