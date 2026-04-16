resource "aws_lambda_function" "connect" {
  function_name = var.connect_lambda_name
  role          = var.lambda_role_arn
  handler       = "connect.handler"
  runtime       = "python3.9"
  filename      = "${path.module}/zips/connect.zip"

  environment {
    variables = {
      CONNECTIONS_TABLE = var.connections_table_name
    }
  }
}

resource "aws_lambda_function" "disconnect" {
  function_name = var.disconnect_lambda_name
  role          = var.lambda_role_arn
  handler       = "disconnect.handler"
  runtime       = "python3.9"
  filename      = "${path.module}/zips/disconnect.zip"

  environment {
    variables = {
      CONNECTIONS_TABLE = var.connections_table_name
    }
  }
}

resource "aws_lambda_function" "message" {
  function_name = var.message_lambda_name
  role          = var.lambda_role_arn
  handler       = "message.handler"
  runtime       = "python3.9"
  filename      = "${path.module}/zips/message.zip"

  source_code_hash = filebase64sha256("${path.module}/zips/message.zip")

  environment {
    variables = {
      CONNECTIONS_TABLE = var.connections_table_name
      MESSAGES_TABLE    = var.messages_table_name
    }
  }
}