provider "aws" {
    region = "eu-west-3"
}

# azs for region configured in the provider
data "aws_availability_zones" "available" {}



module "myapp-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.6.0"
  # insert the 19 required variables here


    name = "myapp-vpc"
    cidr = var.vpc_cidr_block

    # exported attributes "names" can be referenced in docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones#attributes-reference
    azs = data.aws_availability_zones.available.names 
    private_subnets = var.private_subnet_cidr_blocks
    public_subnets = var.public_subnet_cidr_blocks
    
    # Should be true if you want to provision NAT Gateways for each of your private networks
    enable_nat_gateway = true

    # Should be true if you want to provision a single shared NAT Gateway across all of your private networks
    single_nat_gateway = true

    # Should be true to enable DNS hostnames in the VPC
    enable_dns_hostnames = true

    # tags aren't just for human usage. Tags are used to reference components from other components. Like labeling stuff and referencing the labels. In this case we use it for Kubernetes Cloud Controller Manage as a filter to identify vpc and subnets
    tags = {
        "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    }

    # 1. To identify a cluster's subnets, the Kubernetes Cloud Controller Manager (cloud-controller-manager) and ALB Ingress Controller (alb-ingress-controller) query that cluster's subnets by using the following tag as a filter: kubernetes.io/cluster/cluster-name
    # 2. The Cloud Controller Manager and ALB Ingress Controller both require subnets to have either tags: kubernetes.io/role/elb or kubernetes.io/role/internal-elb
    public_subnet_tags = {
        "kubernetes.io/cluster/${local.cluster_name}" = "shared"
        "kubernetes.io/role/elb" = 1 
    }

    # don't forget the '=' before '{'
    private_subnet_tags = {
        "kubernetes.io/cluster/${local.cluster_name}" = "shared"
        "kubernetes.io/role/internal-elb" = 1 
    }

}