resource "aws_vpc" "dev-vpc" {
    cidr_block = "192.0.0.0/24" 
    enable_dns_support =  "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default" #if true, our ec2 instance wil
    tags {
        Name = "dev-vpc"
    }
}