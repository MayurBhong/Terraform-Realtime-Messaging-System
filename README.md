## Terraform Realtime Messaging System 💬

Serverless realtime messaging system built using AWS API Gateway WebSocket, AWS Lambda, DynamoDB, and Terraform. Supports bidirectional communication and real time message broadcasting between connected clients. Uses event driven architecture with fully managed AWS services for scalability and reliability. Infrastructure is provisioned using Terraform with a modular and reusable design.

---

## Architecture 🏗️
<img width="1536" height="1024" alt="Image" src="https://github.com/user-attachments/assets/fc66cfbf-4ce1-45dc-a223-560c7279a9cc" />

Flow:

- User connects via WebSocket  
- API Gateway handles connection  
- $connect Lambda stores connection ID  
- sendMessage Lambda processes and broadcasts messages  
- $disconnect removes connection  
- DynamoDB stores connections and messages  
- CloudWatch logs system activity  

---

## Tech Stack ⚙️

- AWS API Gateway WebSocket  
- AWS Lambda  
- Amazon DynamoDB  
- AWS CloudWatch  
- Terraform  

---

## Project Structure 📁

```
terraform-chat-app/
│
├── main.tf
├── variables.tf
├── outputs.tf
│
├── modules/
│   ├── apigateway/
│   ├── dynamodb/
│   ├── lambda/
│   └── iam/
│
├── chat.html
```

---

## Step by Step Setup 🚀

### Step 1. Create project

mkdir terraform-chat-app  
cd terraform-chat-app  


### Step 2. Create base files

main.tf  
variables.tf  
outputs.tf  


### Step 3. Create modules

mkdir modules  
cd modules  

mkdir apigateway dynamodb lambda iam  


### Step 4. Configure provider

provider "aws" {  
  region = var.aws_region  
}  


### Step 5. Create DynamoDB tables

- connections table for active users  
- messages table for chat data  


### Step 6. Create IAM role

- Lambda execution role  
- Attach policies for DynamoDB and CloudWatch  


### Step 7. Create Lambda functions

- connect  
- disconnect  
- message  


### Step 8. Add Lambda code and zip

Compress-Archive -Path connect.py -DestinationPath connect.zip  
Compress-Archive -Path disconnect.py -DestinationPath disconnect.zip  
Compress-Archive -Path message.py -DestinationPath message.zip  


### Step 9. Create API Gateway WebSocket

- protocol: WEBSOCKET  
- routes: $connect, $disconnect, sendMessage  


### Step 10. Connect integrations

- connect → connect Lambda  
- disconnect → disconnect Lambda  
- message → message Lambda  


### Step 11. Initialize Terraform

terraform init  


### Step 12. Validate

terraform validate  


### Step 13. Deploy

terraform apply  


### Step 14. Get WebSocket URL

wss://xxxx.execute-api.region.amazonaws.com/dev  


### Step 15. Run frontend

python -m http.server 5500  

Open:  
http://localhost:5500/chat.html  

---

## Features ✨

- Realtime messaging using WebSocket  
- Serverless architecture  
- Scalable and event driven  
- Infrastructure as Code using Terraform  

---

## Use Cases 🎯

- Chat applications  
- Notification systems  
- Realtime dashboards  
- Multiplayer applications  

---

## Future Improvements

- Add authentication  
- Improve UI  
- Add group chat  
- Message persistence enhancements  
