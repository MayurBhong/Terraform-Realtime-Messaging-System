output "connect_lambda_arn" {
  value = aws_lambda_function.connect.arn
}

output "disconnect_lambda_arn" {
  value = aws_lambda_function.disconnect.arn
}

output "message_lambda_arn" {
  value = aws_lambda_function.message.arn
}