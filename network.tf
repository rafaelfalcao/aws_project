 #enables vpc connectivity to the internet
/*
resource "aws_internet_gateway" "dev-igw" {
    vpc_id = "${aws_vpc.dev-vpc.id}"

    tags= {
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

    tags = {
        Name = "dev-public-crt"
    }
}
*/

