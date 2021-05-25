module "vpc" {
  source                       = "terraform-aws-modules/vpc/aws"
  version                      = "2.50.0"
  name                         = "${var.env}-vpc"
  cidr                         = var.vpc_cidr
  azs                          = var.azs
  private_subnets              = var.private_subnets
  public_subnets               = var.public_subnets
  enable_nat_gateway           = var.enable_nat_gateway
  single_nat_gateway           = var.single_nat_gateway
  one_nat_gateway_per_az       = var.one_nat_gateway
  create_database_subnet_group = var.create_database_subnet_group
  enable_dns_hostnames         = true
  tags = {
    name         = "${var.env}-vpc"
    environment  = var.env
    "created by" = "terraform"
  }

}