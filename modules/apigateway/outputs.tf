output "websocket_url" {
  value = aws_apigatewayv2_stage.dev.invoke_url
}