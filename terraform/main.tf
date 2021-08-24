provider "aws" {
    region = "eu-west-3"

}

resource "aws_vpc" "dev-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "dev-vpc"
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-3a"
    tags = {
        Name = "dev-sub1"
    }    
}

data "aws_vpc" "existing_vpc" {
    default = true
}


variable "subnet_cidr_block" {
  description = "subnet cidr block"
}


resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = "eu-west-3a"
    tags = {
        Name = "dev-sub2"
    }       

}