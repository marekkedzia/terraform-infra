data "aws_availability_zones" "available_zones" {}

resource "aws_subnet" "subnet_public_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_pub_cidr_block_1
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = var.map_public_ips
}

resource "aws_subnet" "subnet_public_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_pub_cidr_block_2
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = var.map_public_ips
}
