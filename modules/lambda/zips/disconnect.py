import boto3
import os

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["CONNECTIONS_TABLE"])

def handler(event, context):
    connection_id = event["requestContext"]["connectionId"]

    table.delete_item(
        Key={
            "connection_id": connection_id
        }
    )

    return {"statusCode": 200}
