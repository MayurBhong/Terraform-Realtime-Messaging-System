import json
import boto3
import os

def handler(event, context):
    print("CONNECT EVENT:", event)

    try:
        connection_id = event["requestContext"]["connectionId"]

        # Try DynamoDB safely
        if "CONNECTIONS_TABLE" in os.environ:
            dynamodb = boto3.resource("dynamodb")
            table = dynamodb.Table(os.environ["CONNECTIONS_TABLE"])

            table.put_item(
                Item={
                    "connection_id": connection_id
                }
            )

    except Exception as e:
        print("ERROR:", str(e))
        # Do NOT fail connection

    return {
        "statusCode": 200
    }