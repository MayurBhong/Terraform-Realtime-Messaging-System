import json
import boto3
import os

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["MESSAGES_TABLE"])

def handler(event, context):
    connection_id = event["requestContext"]["connectionId"]
    domain = event["requestContext"]["domainName"]
    stage = event["requestContext"]["stage"]

    apigw = boto3.client(
        "apigatewaymanagementapi",
        endpoint_url=f"https://{domain}/{stage}"
    )

    body = json.loads(event["body"])
    message = body.get("message", "hello")

    table.put_item(
        Item={
            "message_id": connection_id,
            "message": message
        }
    )

    apigw.post_to_connection(
        ConnectionId=connection_id,
        Data=json.dumps({"message": message})
    )

    return {"statusCode": 200}