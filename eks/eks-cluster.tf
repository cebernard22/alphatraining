provider "kubernetes" {
    
    host=data.aws_eks_cluster.myapp-cluster.endpoint
    token=data.aws_eks_cluster_auth.myapp-cluster.token
    cluster_ca_certificate=base64decode(data.aws_eks_cluster.myapp-cluster.certificate_authority.0.data)    
    
    
}




data "aws_eks_cluster" "myapp-cluster" {
    name = module.eks.cluster_id

}

data "aws_eks_cluster_auth" "myapp-cluster" {
    name = module.eks.cluster_id
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.1.0"
  # insert the 9 required variables here

  cluster_name = "myapp-eks-cluster"
  cluster_version = "1.17"


  vpc_id=module.myapp-vpc.vpc_id
  


  subnets = module.myapp-vpc.private_subnets


  tags = {
      environment = "development"
      application = "myapp"
  }

  worker_groups = [
      {
          name = "worker-group-1"
          asg_desired_capacity = 1
          instance_type = "t2.medium"
      },
      {
          name = "worker-group-2"
          asg_desired_capacity = 2
          instance_type = "t2.small"
      }      

  ]

}