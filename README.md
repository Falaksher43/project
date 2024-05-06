This repository contains Terraform configuration files to deploy a serverless application on AWS consisting of AWS Lambda, API Gateway, and an S3 bucket.

### Project Structure

```
project/
├── main.tf
├── variables.tf
├── lambda/
│   ├── lambda.tf
│   ├── handler.py
│   ├── output.tf
├── api_gateway/
│   ├── api_gateway.tf
│   ├── custom_domain.tf
|   ├── variables.tf
├── s3/
│   ├── s3_bucket.tf
```

- `main.tf`: Main Terraform configuration file.
- `variables.tf`: Defines the variables used throughout the Terraform configurations.
- `lambda/`: Directory containing Lambda-specific configurations and code.
  - `lambda.tf`: Terraform configuration file for Lambda.
  - `handler.py`: Python code for Lambda function handler.
- `api_gateway/`: Directory containing API Gateway configurations.
  - `api_gateway.tf`: Terraform configuration file for API Gateway.
  - `custom_domain.tf`: Terraform configuration file for custom domain setup.
- `s3/`: Directory containing S3 bucket configurations.
  - `s3_bucket.tf`: Terraform configuration file for S3 bucket setup.

### Deployment Instructions

To deploy this project, follow the steps below:

1. **Initialize Terraform**: Run the following command to initialize Terraform in the project directory:

    ```
    terraform init
    ```

2. **Plan Deployment**: Run the following command to generate an execution plan and see what changes Terraform will apply:

    ```
    terraform plan -var="aws_access_key=aws-access-key" -var="aws_secret_key=aws-secret-key" -var="aws_region=us-west-2"
    ```

3. **Apply Changes**: If the execution plan looks satisfactory, apply the changes with the following command:

    ```
    terraform apply -var="aws_access_key=aws-access-key" -var="aws_secret_key=aws-secret-key" -var="aws_region=us-west-2" -auto-approve
    ```

    Make sure to replace `aws-access-key`, `aws-secret-key`, and `us-west-2` with your AWS access key, secret key, and desired AWS region respectively.

4. **Cleanup**: To tear down the resources created by Terraform, run:

    ```
    terraform destroy -var="aws_access_key=aws-access-key" -var="aws_secret_key=aws-secret-key" -var="aws_region=us-west-2" -auto-approve
    ```

    This will remove all resources provisioned by Terraform. Be cautious as this action is irreversible.

Ensure that you have appropriate permissions and credentials configured in your environment to perform these operations. For further details or customization, refer to individual Terraform configuration files within the project directory.
5. **StateFiles**: Additionally, we can have state file stores in s3, with dynamo db to lock it.

Note: For a custom domain, we have created the custom_domain.tf module. If you wish to use any custom domain, you need to modify the var.custom_domain_name variable with your custom domain and add the ACM certificate URL in the variable var.regional_arn. Then, apply the deployment.