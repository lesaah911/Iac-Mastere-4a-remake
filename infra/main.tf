data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
      name = "name"
      values = [var.instance_config.ami_name]
    }

    owners = [var.instance_config.ami_owner]
}

data "aws_internet_gateway" "existing" {
  filter {
    name = "attachment.vpc-id"
    values = [var.vpc_id]
  }
}

locals {
  prefix = "${var.username}-${var.environment}"
  tags = merge(var.common_tags, { Name = local.prefix })
}

module "network" {
  source = "./modules/network"
  vpc_id = var.vpc_id
  prefix = local.prefix
  tags = local.tags
  subnets = var.subnets
}

module "security" {
  source  = "./modules/security"
  vpc_id  = var.vpc_id
  prefix  = local.prefix
  ingress_rules = var.ingress_rules
  tags  = local.tags
}

module "compute" {
  source                = "./modules/compute"
  prefix                = local.prefix
  subnet_id              = values(module.network.subnet_ids)[0]
  sg_ids                 = [module.security.security_group_id]
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_config.instance_type
  public_key_path        = var.public_key_path
  ssh_user               = var.ssh_user
  ssh_private_key_path   = var.ssh_private_key_path
  inventory_output_path  = "${path.module}/../ansible/inventory.ini"
  tags                   = local.tags
}