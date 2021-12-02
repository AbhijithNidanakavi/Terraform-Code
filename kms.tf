resource "aws_kms_key" "a" {
  description             = "KMS key 1 for week12"
  deletion_window_in_days = 10
}

resource "aws_kms_alias" "a" {
  name          = "alias/week12-kms"
  target_key_id = aws_kms_key.a.key_id
}
