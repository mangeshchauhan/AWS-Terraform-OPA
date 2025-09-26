provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr       = "10.0.0.0/16"
  vpc_name       = "test-vpc"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs= ["10.0.3.0/24", "10.0.4.0/24"]
  azs            = ["ap-south-1a", "ap-south-1b"]
}

module "sg" {
  source  = "./modules/sg"
  vpc_id  = module.vpc.vpc_id
  environment = "dev"
}

module "ec2" {
  source         = "./modules/ec2"
  ami_id         = "ami-018046b953a698135" # Update with latest Amazon Linux or Ubuntu
  instance_type  = "t2.micro"
  subnet_id      = module.vpc.public_subnet_ids[0]
  sg_id          = module.sg.aws_security_group.main.id
  key_name       = "ec2" # Your EC2 KeyPair
  instance_name  = "wordpress-ec2"
}