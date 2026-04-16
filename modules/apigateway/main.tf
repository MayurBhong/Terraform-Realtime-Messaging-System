resource "aws_apigatewayv2_api" "websocket" {
  name                       = "chat-websocket-api"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
}

# -----------------------------
# Integrations
# -----------------------------
resource "aws_apigatewayv2_integration" "connect_integration" {
  api_id           = aws_apigatewayv2_api.websocket.id
  integration_type = "AWS_PROXY"
  integration_method = "POST"

  integration_uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.connect_lambda_arn}/invocations"
}

resource "aws_apigatewayv2_integration" "disconnect_integration" {
  api_id           = aws_apigatewayv2_api.websocket.id
  integration_type = "AWS_PROXY"
  integration_method = "POST"

  integration_uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.disconnect_lambda_arn}/invocations"
}

resource "aws_apigatewayv2_integration" "message_integration" {
  api_id           = aws_apigatewayv2_api.websocket.id
  integration_type = "AWS_PROXY"
  integration_method = "POST"

  integration_uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.message_lambda_arn}/invocations"
}

# -----------------------------
# Routes
# -----------------------------
resource "aws_apigatewayv2_route" "connect" {
  api_id    = aws_apigatewayv2_api.websocket.id
  route_key = "$connect"
  target    = "integrations/${aws_apigatewayv2_integration.connect_integration.id}"
}

resource "aws_apigatewayv2_route" "disconnect" {
  api_id    = aws_apigatewayv2_api.websocket.id
  route_key = "$disconnect"
  target    = "integrations/${aws_apigatewayv2_integration.disconnect_integration.id}"
}

resource "aws_apigatewayv2_route" "message" {
  api_id    = aws_apigatewayv2_api.websocket.id
  route_key = "sendMessage"
  target    = "integrations/${aws_apigatewayv2_integration.message_integration.id}"
}

# -----------------------------
# Stage
# -----------------------------
resource "aws_apigatewayv2_stage" "dev" {
  api_id      = aws_apigatewayv2_api.websocket.id
  name        = "dev"
  auto_deploy = true
}

# -----------------------------
# Permissions
# -----------------------------
resource "aws_lambda_permission" "connect_permission" {
  statement_id  = "AllowConnect"
  action        = "lambda:InvokeFunction"
  function_name = var.connect_lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.websocket.execution_arn}/*"
}

resource "aws_lambda_permission" "disconnect_permission" {
  statement_id  = "AllowDisconnect"
  action        = "lambda:InvokeFunction"
  function_name = var.disconnect_lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.websocket.execution_arn}/*"
}

resource "aws_lambda_permission" "message_permission" {
  statement_id  = "AllowMessage"
  action        = "lambda:InvokeFunction"
  function_name = var.message_lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.websocket.execution_arn}/*"
}