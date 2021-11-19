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
# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = "VirtualPrivateCloud"
#   #Classless Inter-Domain Routing 
#   #IPv4 addresses for the vpc
#   cidr = "192.168.0.0/16"

#   #availability zones
#   azs = ["eu-west-2a", "eu-west-2b"] //, "eu-west-2c"]

#   #SUBNETS - range of ip addresses in the vpc - subset of CIDR

#   private_subnets = ["192.168.1.0/24", "192.168.2.0/24"]

#   #to route to an internet gateway
#   #needs public ipv4 or elastic ip 
#   public_subnets = ["192.168.100.0/24"] //, "10.0.102.0/24", "10.0.103.0/24"]

#   #traffic routed to a vpn gateway for a site-to-site vpn connection
#   #enables access to your remote network from your VPC by creating an AWS Site-to-Site VPN (Site-to-Site VPN) connection, 
#   #and configuring routing to pass traffic through the connection. 
#   enable_vpn_gateway = true
  
#   #enables internet access from the  inside 
#   enable_nat_gateway = true

# }


resource "aws_subnet" "dev-subnet-public-1" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    count = length(data.aws_availability_zones.available.names)
    cidr_block = "192.168.101.0/24"
    map_public_ip_on_launch = "true" #public subnet
    availability_zone = data.aws_availability_zones.available.names[0]

    tags = {
        Name = "dev-subnet-public-1"
    }
}

resource "aws_subnet" "dev-subnet-public-2" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    count = length(data.aws_availability_zones.available.names)
    cidr_block = "192.168.102.0/24"
    map_public_ip_on_launch = "true" #public subnet
    availability_zone = data.aws_availability_zones.available.names[1]

    tags = {
        Name = "dev-subnet-public-2"
    }
}

resource "aws_subnet" "dev-subnet-private-1" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    count = length(data.aws_availability_zones.available.names)
    cidr_block = "192.168.1.0/24"
    map_public_ip_on_launch = "false" 
    availability_zone = data.aws_availability_zones.available.names[0]

    tags = {
        Name = "dev-subnet-private-1"
    }
}

resource "aws_subnet" "dev-subnet-private-2" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    count = length(data.aws_availability_zones.available.names)
    cidr_block = "192.168.2.0/24"
    map_public_ip_on_launch = "false" 
    availability_zone = data.aws_availability_zones.available.names[1]

    tags = {
        Name = "dev-subnet-private-2"
    }
}

data "aws_availability_zones" "available" {
    state="available"
}
