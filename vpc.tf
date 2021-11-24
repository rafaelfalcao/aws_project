resource "aws_vpc" "dev-vpc" {
    cidr_block = "192.168.0.0/16" 
    enable_dns_support =  "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default" #if true, our ec2 instance will use all the hardware
    tags = {
        Name = "dev-vpc"
    }
}

 resource "aws_subnet" "dev-subnet-public" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    count = length(data.aws_availability_zones.available.names)
    cidr_block = "192.168.${count.index+100}.0/24"
    map_public_ip_on_launch = "true" #public subnet
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = {
        Name = "dev-subnet-public-${count.index}"
    }
}

resource "aws_subnet" "dev-subnet-private" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    count = length(data.aws_availability_zones.available.names)
    cidr_block = "192.168.${count.index}.0/24"
    map_public_ip_on_launch = "false" 
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = {
        Name = "dev-subnet-private-${count.index}"
    }
}

data "aws_availability_zones" "available" {
    state="available"
}
 
data "aws_subnet_ids" "private_subnets_ids"{
    vpc_id = "${aws_vpc.dev-vpc.id}"
}