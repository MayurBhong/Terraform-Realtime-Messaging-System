resource "aws_dynamodb_table" "connections" {
  name         = var.connections_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "connection_id"

  attribute {
    name = "connection_id"
    type = "S"
  }

  tags = {
    Project = "terraform-chat-app"
  }
}

resource "aws_dynamodb_table" "messages" {
  name         = var.messages_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "message_id"

  attribute {
    name = "message_id"
    type = "S"
  }

  tags = {
    Project = "terraform-chat-app"
  }
}