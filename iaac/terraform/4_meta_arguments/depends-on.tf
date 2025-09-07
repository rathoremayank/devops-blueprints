# Consider a scenario where you want to create multiple resources of same type with different configurations.
# For example, you want to create multiple subnets in a VPC with different CIDR blocks.
# You can use 'for_each' meta-argument to achieve this.

provider "aws" {
    region = "ap-south-1"
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "main-vpc"
    }  
}

variable "subnets" {
    default = {
        public_subnet_1  = "10.0.1.0/24"
        public_subnet_2  = "10.0.2.0/24"
        private_subnet_1 = "10.0.3.0/24"
        private_subnet_2 = "10.0.4.0/24"  
    }
}

resource "aws_subnet" "this" {
    # Using 'depends_on' to ensure that the VPC is created before any subnets are created
    depends_on = [ aws_vpc.main ]


    vpc_id = aws_vpc.main.id
    # This will create 4 subnets with different CIDR blocks as defined in the variable 'subnets'
    for_each = var.subnets
    cidr_block = each.value
    tags = {
        Name = each.key
    }
}