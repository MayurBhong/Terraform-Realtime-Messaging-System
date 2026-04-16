# -----------------------------
# Provider
# -----------------------------
provider "aws" {
  region = var.aws_region
}

# -----------------------------
# DynamoDB
# -----------------------------
module "dynamodb" {
  source = "./modules/dynamodb"

  connections_table_name = var.connections_table_name
  messages_table_name    = var.messages_table_name
}

# -----------------------------
# IAM
# -----------------------------
module "iam" {
  source = "./modules/iam"

  lambda_role_name = var.lambda_role_name
}

# -----------------------------
# Lambda
# -----------------------------
module "lambda" {
  source = "./modules/lambda"

  lambda_role_arn        = module.iam.lambda_role_arn
  connections_table_name = var.connections_table_name
  messages_table_name    = var.messages_table_name

  connect_lambda_name    = "connectHandler"
  disconnect_lambda_name = "disconnectHandler"
  message_lambda_name    = "messageHandler"
}

# -----------------------------
# API Gateway WebSocket
# -----------------------------
module "apigateway" {
  source = "./modules/apigateway"

  connect_lambda_arn    = module.lambda.connect_lambda_arn
  disconnect_lambda_arn = module.lambda.disconnect_lambda_arn
  message_lambda_arn    = module.lambda.message_lambda_arn
  region                 = var.aws_region
}

# -----------------------------
# Outputs
# -----------------------------
output "websocket_url" {
  value = module.apigateway.websocket_url
}