provider "aws" {
    region = "ap-south-1"
}

# Just a sample EC2 instance created by terraform
resource "aws_instance" "this" {
    # This count will create 5 identical EC2 instances. Count is a meta argument.
    count = 5

    ami = "ami-0360c520857e3138f"
    instance_type = "t2.micro"
    tags = {
        Name = "demo-tf-server"
    }
}
