terraform {
    backend "s3" {
        bucket = "terraform-state-bucket"
        key    = "main/terraform.tfstate"
        region = "ap-south-1"
        dynamodb_table = "terraform-locks"
        encrypt = true
    }
}

provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "this" {
    ami = "ami-0360c520857e3138f"
    instance_type = "t2.micro"
    tags = {
        Name = "demo-tf-server"
    }
}


# Below S3 Bucket and DynamoDB table resources are created to support remote state file storage and locking.

# This S3 Bucket will be used to store terraform state file
resource "aws_s3_bucket" "terraform-state" {
    bucket = "terraform-state-bucket"
    lifecycle {
        prevent_destroy = true
    }
    tags = {
        Name        = "terraform-state-bucket"
        Environment = "Dev"
    }
}

# To enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "versioning" {
    bucket = aws_s3_bucket.terraform-state.id
    versioning_configuration {
        status = "Enabled"
    }
}

# To enable default encryption on the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
    bucket = aws_s3_bucket.terraform-state.id
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}
# To block public access to the S3 bucket
resource "aws_s3_account_public_access_block" "public_access_block" {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}



# This DynamoDB table will be used for state file locking
resource "aws_dynamodb_table" "terraform-locks" {
    name         = "terraform-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }

    tags = {
        Name        = "terraform-locks"
    }
}

# Outputs just for display purpose. Not being used anywhere.
output "s3_bucket_arn" {
    value = aws_s3_bucket.terraform-state.arn
    description = "ARN of the S3 bucket to store terraform state file"
}

output "dynamodb_table_name" {
    value = aws_dynamodb_table.terraform-locks.name
    description = "Name of the DynamoDB table to lock terraform state file"
}