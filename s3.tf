resource "aws_s3_bucket" "ece592-week10-nidanakavi" {
  bucket = "ece592-week10-nidanakavi"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.a.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    Name        = "ece592-week10-nidanakavi"
    Environment = "Dev"
  }
  versioning {
    enabled = true
  }
  lifecycle_rule {
    enabled = true

    expiration {
      days = 30
    }
  }

}

resource "aws_lambda_permission" "week10-bucket-lambda" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.ece592-week10-nidanakavi.arn
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.ece592-week10-nidanakavi.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }
}
