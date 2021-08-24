provider "aws" {region = "eu-west-3"}
variable "subnet_cidr_block" {}
variable "vpc_cidr_block" {}
variable "env_prefix" {}
variable "my_ip" {}
variable "avail_zone" {}
variable "public_key_location" {}





resource "aws_vpc" "myapp-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "${var.env_prefix}-vpc"
    }
}

resource "aws_subnet" "myapp-subnet-1" {
    vpc_id = aws_vpc.myapp-vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.avail_zone
    tags = {
        Name = "${var.env_prefix}-sub1"
    }    
}




resource "aws_default_route_table" "myapp-rtb" {
    default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myapp-igw.id

    }
    tags = {
        Name = "${var.env_prefix}-main-rtb"
    } 
}    



resource "aws_internet_gateway" "myapp-igw" {
    vpc_id = aws_vpc.myapp-vpc.id
    tags = {
        Name = "${var.env_prefix}-igw"
    }       
}



resource "aws_default_security_group" "default-sg" {
    
    vpc_id = aws_vpc.myapp-vpc.id
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.my_ip]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }
    tags = {
        Name = "${var.env_prefix}-default-sg"
    }
}




data "aws_ami" "latest-amazon-linux-image" {
    most_recent = true
    owners      = ["amazon"]
    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }

}





resource "aws_key_pair" "myapp-key-pair" {
    key_name = "server-key"
    public_key = "${file(var.public_key_location)}"
}


resource "aws_instance" "myapp-server" {
    ami = data.aws_ami.latest-amazon-linux-image.id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.myapp-subnet-1.id
    vpc_security_group_ids = [aws_default_security_group.default-sg.id]
    availability_zone = var.avail_zone
    associate_public_ip_address = true
    key_name = aws_key_pair.myapp-key-pair.key_name
    user_data= file("entry-script.sh")




    tags = {
        Name = "${var.env_prefix}-server"
    }
}



output "server_ip" {
  value       = aws_instance.myapp-server.public_ip
}
