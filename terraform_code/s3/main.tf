
#---------------------------------------------------------#
#                 Terraform Introduction                  #
#                    Create S3 + ECR                      #
#                    ECR: cloud, sun                      #
#                                                         #
#---------------------------------------------------------#


# Create S3 Bucket
resource "aws_s3_bucket" "pictures" {
  bucket = "${var.env}-pictures"
  tags = {
    Name        = "My bucket"
    Environment = "var.env"
  }
}

# Create ACL for S3
resource "aws_s3_bucket_acl" "pictures_acl" {
  bucket = aws_s3_bucket.pictures.id
  acl    = "public-read"
}

# public access to S3
resource "aws_s3_bucket_public_access_block" "pictures_acl" {
  bucket = aws_s3_bucket.pictures.id

  block_public_acls       = false
  block_public_policy     = false
  restrict_public_buckets = false
  ignore_public_acls      = false
}

# Create Folder cloud
resource "aws_s3_object" "cloud" {
    bucket = "${aws_s3_bucket.pictures.id}"
    acl    = "public-read"
    key    = "cloud/"
    source = "/dev/null"
}

# Create Folder sun
resource "aws_s3_object" "sun" {
    bucket = "${aws_s3_bucket.pictures.id}"
    acl    = "public-read"
    key    = "sun/"
    source = "/dev/null"
}

# Create ECR repository for cloud
resource "aws_ecr_repository" "ecr_docker_cloud" {
  name                 = "cloud"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Create ECR repository for sun
resource "aws_ecr_repository" "ecr_docker_sun" {
  name                 = "sun"
  image_tag_mutability = "IMMUTABLE"
  #image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
