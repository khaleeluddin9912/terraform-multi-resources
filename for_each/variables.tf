variable "subnet_map" {
    type = map(object({
        cidr_block = string
        availability_zone = string
    }))
}

variable "ec2_map" {
    type = map(object({
        ami           = string
        instance_type = string
    }))
  
}
