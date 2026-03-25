module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  name = "dev-vpc"
  cidr = "10.0.0.0/16"

  azs = ["ap-south-1a", "ap-south-1b"]

  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.3.0"

  name = "dev-instance"

  instance_type = "t3.micro"
  ami           = "ami-0f5ee92e2d63afc18"
  key_name      = "user1"

  subnet_id = module.vpc.public_subnets[0]

  vpc_security_group_ids = [
    module.vpc.default_security_group_id
  ]

  associate_public_ip_address = true

  tags = {
    Environment = "dev"
  }
}
