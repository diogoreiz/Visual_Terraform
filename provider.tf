terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

#route table

resource "aws_route_table" "route_public" {
  vpc_id = aws_vpc.main.id

  route = []

  tags = {
    Name = "example"
  }
}


resource "aws_route_table" "route_privada" {
  vpc_id = aws_vpc.main.id

  route = []

  tags = {
    Name = "example"
  }
}

#internet gateway : 
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

#nat gateway
resource "aws_nat_gateway" "nat_diogo" {
  connectivity_type = "private"
  subnet_id         = aws_subnet_public.main.id
}

#elastic ip : 
resource "aws_eip" "lb" {
  instance = aws_instance.web.id (aqui o nome da sua ec2)
  vpc      = true
}

#auto scaling

#acrescenta no terraform autoscaling:

resource "aws_autoscaling_group" "terramino" {
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.terramino.name
  vpc_zone_identifier  = module.vpc.public_subnets
}
