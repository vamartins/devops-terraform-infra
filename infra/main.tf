module "main" {
    source = "."
    aws_account_id = var.AWS_ACCOUNT_ID
    aws_deployment_role = var.AWS_DEPLOYMENT_ROLE
    aws_region = var.AWS_REGION
    az = var.az
    environment = var.ENVIRONMENT
    application_name = var.application_name
    technical_owner = var.technical_owner
    businessunit = var.business_unit
    tier = var.tier
    classification =var.classification
    customerdomain_sharedservices_account = var.CUSTOMERDOMAIN_SHAREDSERVICES_ACCOUNT
    instance_type = var.instance_type
    vpc_cidr_block = var.vpc_cidr_block
    subnet_public_cidr = var.subnet_public_cidr
    hosted_zone = false
    kp_aws_user = var.kp_aws_user
    awslab_file_name = var.awslab_file_name
    logs_path = var.logs_path
    ci_username = var.ci_username
    clean_infra_state_address = var.clean_infra_state_address
    terraform_version = var.TERRAFORM_VERSION
}