module "network" {
  source = "./modules/network"
 
}

module "database" {
  source = "./modules/database"

  vpc_id             = module.network.vpc_id
  private_subnet_ids = [module.network.private_subnet_ids]

}

