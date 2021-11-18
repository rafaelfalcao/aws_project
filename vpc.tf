resource "aws_vpc" "dev-vpc" {
    cidr_block = "10.0.0.0/24" 
    enable_dns_support =  "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default" #if true, our ec2 instance will use all the hardware

    tags = {
        Name = "dev-vpc"
    }
}

resource "aws_subnet" "dev-subnet-public-1" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    count = length(data.aws_availability_zones.available.names)
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true" #public subnet
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = {
        Name = "dev-subnet-public-1"
    }
}

resource "aws_subnet" "dev-subnet-public-2" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    count = length(data.aws_availability_zones.available.names)
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true" #public subnet
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = {
        Name = "dev-subnet-public-12"
    }
}

resource "aws_subnet" "dev-subnet-private-1" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    count = length(data.aws_availability_zones.available.names)
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "false" 
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = {
        Name = "dev-subnet-private-1"
    }
}

resource "aws_subnet" "dev-subnet-private-2" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    count = length(data.aws_availability_zones.available.names)
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false" 
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = {
        Name = "dev-subnet-private-2"
    }
}

data "aws_availability_zones" "available" {
    state="available"
}
