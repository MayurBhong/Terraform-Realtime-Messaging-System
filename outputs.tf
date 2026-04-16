output "connections_table_name" {
  description = "DynamoDB connections table"
  value       = module.dynamodb.connections_table_name
}

output "messages_table_name" {
  description = "DynamoDB messages table"
  value       = module.dynamodb.messages_table_name
}