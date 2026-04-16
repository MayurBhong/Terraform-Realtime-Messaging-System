variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

# -----------------------------
# DynamoDB
# -----------------------------
variable "connections_table_name" {
  description = "DynamoDB table for active connections"
  type        = string
  default     = "chat-connections"
}

variable "messages_table_name" {
  description = "DynamoDB table for chat messages"
  type        = string
  default     = "chat-messages"
}

# -----------------------------
# IAM
# -----------------------------
variable "lambda_role_name" {
  description = "IAM role name for Lambda"
  type        = string
  default     = "chat-lambda-role"
}