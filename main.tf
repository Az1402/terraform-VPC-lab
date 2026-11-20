provider "aws" {
  region = "ap-southeast-2"
}

# Get available availability zones
data "aws_availability_zones" "available" {
  state = "available"
}



# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "LIFECYCLE-VPC"
  }
}




# Create Subnet A
resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "SUBNET-A"
  }
}

# Create Subnet B
resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "SUBNET-B"
  }
}






# Create EC2 in Subnet A
resource "aws_instance" "server_a" {
  ami           = "ami-XXXX"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.subnet_a.id

  tags = {
    Name = "SERVER-A"
  }

  
}




# Create EC2 in Subnet B
resource "aws_instance" "server_b" {
  ami           = "ami-XXXXX"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.subnet_b.id

  tags = {
    Name = "SERVER-B"
  }

 
}