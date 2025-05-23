# vpc (dns enabled) 10.38.0.0/16
resource "aws_vpc" "this" {
  cidr_block = "10.38.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
      Name = "${var.project_name}-vpc"
    }
}

# s3 VPC endpoint
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.this.id
  service_name = "com.amazonaws.us-east-1.s3"

  tags = {
    Name = "${var.project_name}-vpce"
  }
}


# 2 private subnets RT & association to NAT gateway & s3 VPC endpoint
resource "aws_subnet" "priv" {
  count = 2
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + 30)
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)

  tags = {
    Name = "${var.project_name}-private-subnet-${count.index}"
  }
  
}

# NAT gateway
resource "aws_nat_gateway" "this" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.priv[0].id
  tags = {
    Name = "${var.project_name}-nat-gateway"
  }
}

resource "aws_route_table" "priv" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    vpc_endpoint_id = aws_vpc_endpoint.s3.id
  }
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }
  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

resource "aws_route_table_association" "priv" {
  count = 2
  subnet_id = aws_subnet.priv[count.index].id
  route_table_id = aws_route_table.priv.id
}

# 1 public subnets RT & association to IGW
# 2 public subnets 10.38.224.0/21
resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + 10)
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)

  tags = {
    Name = "${var.project_name}-public-subnet-${count.index}"
  }
  
}

# internet gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-igw"
  }
  
}

# route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id

  }
  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count = 2
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id

}
# SM studio EIP
resource "aws_eip" "this" {
  domain       = "vpc"
  depends_on = [ aws_internet_gateway.this ]
  tags = {
    Name = "${var.project_name}-eip"
  }
}


# security group for SM studio 443
resource "aws_security_group" "sm_studio" {
  vpc_id = aws_vpc.this.id
  name   = "${var.project_name}-sm-studio-sg"
  description = "Security group for SM Studio"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 988
    to_port     = 988
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 1018
    to_port     = 1023
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.project_name}-sm-studio-sg"
  }
}
  # Security Group that allows outbound NFS traffic for SageMaker Notebooks Domain (2049, 988, 1018-1023)
