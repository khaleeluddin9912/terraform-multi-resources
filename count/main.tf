# creating 2 subnet with count
locals {
  project = "project-01"
}

# creating vpc
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "${local.project}-vpc"
    }
}

# creating subnet
resource "aws_subnet" "my_subnets" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.${count.index}.0/24"
    count = 2
    tags = {
      Name = "${local.project}-subnet-${count.index + 1}"
    }
}


# creating 4 ec2 instance 
resource "aws_instance" "main" {
  count = length(var.ec2_config)
  ami = var.ec2_config[count.index].ami
  instance_type = var.ec2_config[count.index].instance_type
  subnet_id = element(aws_subnet.my_subnets[*].id, count.index % length(aws_subnet.my_subnets))

  tags = {
    Name = "${local.project}-instance-${count.index + 1}"
  }
  
}

output "aws_subnet_ids" {
  value = aws_subnet.my_subnets[*].id
}
