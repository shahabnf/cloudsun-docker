
# Create S3 Bucket
resource "aws_s3_bucket" "pictures" {
  bucket = "tf-${var.env}-pictures/cloud"
  tags = {
    Name        = "My bucket"
    Environment = "var.env"
  }
}

# Create ACL for S3
resource "aws_s3_bucket_acl" "pictures_acl" {
  bucket = aws_s3_bucket.pictures.id
  acl    = "public"
}

# public access to S3
resource "aws_s3_bucket_public_access_block" "pictures_acl" {
  bucket = aws_s3_bucket.pictures.id

  block_public_acls       = false
  block_public_policy     = false
  restrict_public_buckets = false
  ignore_public_acls      = false
}

# # Create S3 Bucket
# resource "aws_s3_bucket" "peers3" {
#   bucket = "peering-acs730-final-project"
#   tags = {
#     Name        = "My bucket"
#     Environment = "var.env"
#   }
# }

# # Create ACL for S3
# resource "aws_s3_bucket_acl" "peers3acl" {
#   bucket = aws_s3_bucket.peers3.id
#   acl    = "private"
# }

# # Limit access to S3
# resource "aws_s3_bucket_public_access_block" "peers3acl" {
#   bucket = aws_s3_bucket.peers3.id

#   block_public_acls       = true
#   block_public_policy     = true
#   restrict_public_buckets = true
#   ignore_public_acls      = true
# }