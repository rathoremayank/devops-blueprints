terraform {
    backend "s3" {
        bucket = "terraform-state-bucket"
        key    = "main/terraform.tfstate"
        region = "ap-south-1"
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