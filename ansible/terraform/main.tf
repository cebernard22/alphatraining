provider "aws" {region = "eu-west-3"}





resource "aws_vpc" "myapp-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "${var.env_prefix}-vpc"
    }
}





module "myapp-subnet" {
    source = "./modules/subnet"    
    subnet_cidr_block = var.subnet_cidr_block
    vpc_cidr_block = var.vpc_cidr_block
    env_prefix = var.env_prefix
    avail_zone = var.avail_zone
    vpc_id = aws_vpc.myapp-vpc.id
    default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
}




module "myapp-servers" {
    source = "./modules/servers"    
    vpc_id = aws_vpc.myapp-vpc.id    
    my_ip = var.my_ip
    avail_zone = var.avail_zone
    env_prefix = var.env_prefix
    public_key_location = var.public_key_location
    subnet_id = module.myapp-subnet.subnet.id
}


