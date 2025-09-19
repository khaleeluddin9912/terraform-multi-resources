subnet_map = {
  "public_subnet" = {
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
  },
  "private_subnet" = {
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1b"
  }
}

ec2_map = {
  "ubuntu" = {
    ami           = "ami-02d26659fd82cf299"
    instance_type = "t2.micro"
  },
    "amazon-linux" = {
        ami           = "ami-0b982602dbb32c5bd"
        instance_type = "t2.micro"
    }
}
