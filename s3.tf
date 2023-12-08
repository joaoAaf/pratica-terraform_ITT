resource "aws_s3_bucket" "s3-website" {
  bucket = "s3-website-itt"
  tags = {
    Name = "s3-website-itt"
  }
}

resource "aws_s3_bucket_public_access_block" "s3-website" {
  bucket = aws_s3_bucket.s3-website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "s3-website" {
  bucket = aws_s3_bucket.s3-website.id

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "s3-website" {
  bucket = aws_s3_bucket.s3-website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3-website" {
  depends_on = [
    aws_s3_bucket_ownership_controls.s3-website,
    aws_s3_bucket_public_access_block.s3-website,
  ]
  bucket = aws_s3_bucket.s3-website.id
  acl = "public-read"
}

output "s3-website" {
  value = "http://${aws_s3_bucket.s3-website.bucket}.s3-website.us-east-1.amazonaws.com"
}
