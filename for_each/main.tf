# for_each example
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

# creating 2 subnet
resource "aws_subnet" "my_subnet" {
    for_each = var.subnet_map
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = each.value.cidr_block
    availability_zone = each.value.availability_zone

    tags = {
      Name = "${local.project}-subnet-${each.key}"
    }
}

# creating 2 ec2 instance
resource "aws_instance" "my_ec2_instances" {
    for_each = var.ec2_map
    ami = each.value.ami
    instance_type = each.value.instance_type
    subnet_id = values(aws_subnet.my_subnet)[index(keys(var.ec2_map), each.key) % length(aws_subnet.my_subnet)].id
    tags = {
        Name = "${local.project}-instance-${each.key}"
    }
}
