resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = var.bucket_name
  policy = file(var.policy_file_path)
}
