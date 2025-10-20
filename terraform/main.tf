provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  cluster_name = var.cluster_name
  vpc_cidr     = var.vpc_cidr
  region       = var.region
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = concat(module.vpc.private_subnet_ids, module.vpc.public_subnet_ids)
  desired_size    = var.node_desired_size
  max_size        = var.node_max_size
  min_size        = var.node_min_size
  instance_types  = var.instance_types
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_ca_certificate)
  token                  = module.eks.cluster_auth_token
}

provider "helm" {
  kubernetes = {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_ca_certificate)
    token                  = module.eks.cluster_auth_token
  }
}

module "alb_controller" {
  source = "./modules/alb-controller"

  cluster_name     = module.eks.cluster_name
  cluster_oidc_url = module.eks.cluster_oidc_url
  cluster_oidc_arn = module.eks.cluster_oidc_arn
  vpc_id           = module.vpc.vpc_id

  depends_on = [module.eks]
}