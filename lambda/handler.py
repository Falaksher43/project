import boto3
import random
import string
import os

def lambda_handler(event, context):
    # Generate random data
    generate_random_data = lambda size: ''.join(random.choices(string.ascii_letters + string.digits, k=size))

    # Create a file with random data
    create_random_file = lambda file_path, size: open(file_path, 'w').write(generate_random_data(size))

    # Upload file to S3
    def upload_to_s3(file_path, object_key, bucket_name):
        aws_access_key_id = os.environ['AWS_ACCESS_KEY_ID']
        aws_secret_access_key = os.environ['AWS_SECRET_ACCESS_KEY']
        s3 = boto3.client('s3', aws_access_key_id=aws_access_key_id, aws_secret_access_key=aws_secret_access_key)
        s3.upload_file(file_path, bucket_name, object_key)

    # Set the file size (in bytes)
    file_size = 1024  # 1 KB

    # Generate a random file name
    file_name = ''.join(random.choices(string.ascii_lowercase, k=10)) + '.txt'

    # Set the path to save the file
    file_path = os.path.join('/tmp', file_name)

    # Create a file with random data
    create_random_file(file_path, file_size)

    # Set the S3 bucket details
    bucket_name = os.environ['BUCKET_NAME']
    object_key = file_name  # Using the same name as the file for simplicity

    # Upload the file to S3
    upload_to_s3(file_path, object_key, bucket_name)

    # Clean up: delete the local file
    os.remove(file_path)
