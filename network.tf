/* #enables vpc connectivity to the internet
resource "aws_internet_gateway" "dev-igw" {
    vpc_id = "${aws_vpc.dev-vpc.id}"

    tags {
        Name = "dev-igw"
    }
}

resource "aws_route_table" "dev-public-crt" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0"         //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.dev-igw.id}" 
    }

    tags {
        Name = "dev-public-crt"
    }
}

resource "aws_security_group" "ssh-allowed" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }   
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the production. 
        // Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
    } 
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }    
    
    tags {
        Name = "ssh-allowed"
    }
}  */