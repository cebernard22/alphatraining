# comes from "random" provider
resource "random_string" "suffix" {
    length = 8
    special = false
}

# A local value assigns a name to an expression, so you can use it multiple times within a module without repeating it: https://www.terraform.io/docs/configuration/locals.html
locals {
    example = "this can be any expression"
    cluster_name = "myapp-eks-${random_string.suffix.result}" # variable but with expression as value
}

variable private_subnet_cidr_blocks {}
variable public_subnet_cidr_blocks {}
variable vpc_cidr_block {}
