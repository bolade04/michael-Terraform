terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.60.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Create vpc; CIDR 10.0.0.0/16
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
	"Name" = "mikeb_vpc"
  }
}

# Public Subnets 10.0.0.0/24
resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  #netnum = number to change based on subnet addition: 1st subnet 10.0.0.0/24, 10.0.1.0/24, 10.0.2.0/24 
  # word wrap - view
  map_public_ip_on_launch = true
}

# Private Subnets 10.0.0.0/24
# Public Route Table
# Private Route Table
# IGW
# NGW 