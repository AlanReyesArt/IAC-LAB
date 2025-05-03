
output "lambda_function_name" {
  value       = aws_lambda_function.process_reservation.function_name
  description = "Nombre de la función Lambda creada"
}

output "lambda_function_arn" {
  value       = aws_lambda_function.process_reservation.arn
  description = "ARN de la función Lambda"
}

output "lambda_invoke_arn" {
  value       = aws_lambda_function.process_reservation.invoke_arn
  description = "ARN para invocar la función Lambda"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.reservations.name
  description = "Nombre de la tabla DynamoDB"
}

output "dynamodb_table_arn" {
  value       = aws_dynamodb_table.reservations.arn
  description = "ARN de la tabla DynamoDB"
}