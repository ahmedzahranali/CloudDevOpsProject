module "network" {
  source = "./modules/network"
}

module "server" {
  source = "./modules/server"

  vpc_id = module.network.vpc_id
  private_subnet_id = module.network,private_subnet_ids[0]
}

module "eks" {
  source = "./modules/eks"

  vpc_id = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
}

module "ecr" {
  source = "./modules/ecr"
}
