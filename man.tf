resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "infra_aws_diogo"
  }
}

#EC2
resource "aws_instance" "infra_diogo" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}


resource "aws_vpc_ipv4_cidr_block_association" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/16"
}

#Subnets
resource "aws_subnet_public" "in_secondary_cidr" {
  vpc_id     = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block = "10.0.0.0/16"
}


resource "aws_subnet_private" "in_secondary_cidr" {
  vpc_id     = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block = "10.0.0.0/16"
}