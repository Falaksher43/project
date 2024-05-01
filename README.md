Here's a high-level overview of how to structure your Terraform configuration:



project/
├── main.tf
├── variables.tf
├── lambda/
│   ├── lambda.tf
│   ├── handler.py
├── api_gateway/
│   ├── api_gateway.tf
│   ├── custom_domain.tf
├── s3/
│   ├── s3_bucket.tf