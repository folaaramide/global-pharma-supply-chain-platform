resource "aws_s3_bucket" "logs" {

  bucket = "global-pharma-supply-chain-logs-040396448143"

  tags = {

    Name = "pharma-logs"

  }

}

resource "aws_s3_bucket_versioning" "logs" {

  bucket = aws_s3_bucket.logs.id

  versioning_configuration {

    status = "Enabled"

  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {

  bucket = aws_s3_bucket.logs.id

  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"

    }

  }

}

resource "aws_s3_bucket_lifecycle_configuration" "logs" {

  bucket = aws_s3_bucket.logs.id

  rule {

    id = "delete-old-logs"

    status = "Enabled"

    filter {}

    expiration {

      days = 90

    }

  }

}