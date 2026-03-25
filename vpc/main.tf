module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  # Basic VPC
  name = "rohan-prod-vpc"
  cidr = "10.0.0.0/16"

  azs = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  # Subnets

  # Public (ALB, NAT)
  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  # Private (App servers)
  private_subnets = [
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]

  # Database (RDS)
  database_subnets = [
    "10.0.5.0/24",
    "10.0.6.0/24"
  ]

  # Internal (no internet)
  intra_subnets = [
    "10.0.7.0/24",
    "10.0.8.0/24"
  ]

  #  Internet Gateway
  create_igw = true

  #  NAT Gateway
  enable_nat_gateway = true
  single_nat_gateway = true

  #  DNS
  enable_dns_hostnames = true
  enable_dns_support   = true

  #  Auto assign public IP
  map_public_ip_on_launch = true

  #  Subnet Groups
  create_database_subnet_group    = true
  create_elasticache_subnet_group = true
  create_redshift_subnet_group    = true

  #  Flow Logs
  enable_flow_log       = true
  flow_log_traffic_type = "ALL"

  #  Tags
  tags = {
    Environment = "production"
    Project     = "complete-vpc"
    Owner       = "Rohan"
  }

  public_subnet_tags = {
    Tier = "public"
  }

  private_subnet_tags = {
    Tier = "private"
  }

  database_subnet_tags = {
    Tier = "database"
  }

  intra_subnet_tags = {
    Tier = "internal"
  }
}
