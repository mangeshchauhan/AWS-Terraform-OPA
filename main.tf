module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
  azs                = ["us-east-1a", "us-east-1b"]
  environment        = var.environment
  tags               = var.environment
}

module "ec2" {
  source               = "./modules/ec2"
  ami                  = "ami-0c02fb55956c7d316" # Example Amazon Linux 2
  instance_type        = var.instance_type
  subnet_id            = element(module.vpc.public_subnet_ids, 0)
  associate_public_ip  = true
  environment          = var.environment
  tags                 = var.environment
}

/*module "s3" {
  source        = "./modules/s3"
  bucket_name   = "pac-demo-bucket-${var.environment}"
  environment   = var.environment
  tags          = var.environment
}*/
