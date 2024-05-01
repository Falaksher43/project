# Define the S3 bucket without specifying the ACL
resource "aws_s3_bucket" "Upload-bucket" {
  bucket = "upload-api-lambda-update"
}

# Manage the ACL separately using aws_s3_bucket_acl resource
#resource "aws_s3_bucket_acl" "bucket_acl" {
 # bucket = aws_s3_bucket.Upload-bucket.id

 # acl = "private"
#}