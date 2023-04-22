module "elearning-vpc" {
    source      = "../modules/vpc"

    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION  = var.AWS_REGION
}

module "elearning-rds" {
    source      = "../modules/rds"

    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION  = var.AWS_REGION
    vpc_private_subnet1 = module.elearning-vpc.private_subnet1_id
    vpc_private_subnet2 = module.elearning-vpc.private_subnet2_id
    vpc_private_subnet3 = module.elearning-vpc.private_subnet3_id
    vpc_id = module.elearning-vpc.my_vpc_id
}

output "module-rds-endpoint" {
  value = module.elearning-rds.rds_prod_endpoint
}
