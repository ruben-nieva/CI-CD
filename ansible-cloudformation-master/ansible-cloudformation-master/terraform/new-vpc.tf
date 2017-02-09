resource "aws_vpc"  "custom_vpc" {
tags {

Name = "${var.project}" 
}
cidr_block = "10.0.0.0/16"
}

######### web subnet defination ###########
resource "aws_subnet" "pub-subnet-az1" {
vpc_id = "${aws_vpc.custom_vpc.id}"
availability_zone = "${var.primary_az}"
cidr_block = "10.0.1.0/24"
tags {
Name = "web-subnet-1"
}
}

resource "aws_subnet" "pub-subnet-az2" {
vpc_id = "${aws_vpc.custom_vpc.id}"
availability_zone = "${var.secondary_az}"
cidr_block = "10.0.2.0/24"
tags {
Name = "web-subnet-2"
}
}
##### app subnet #########
resource "aws_subnet" "pri-app-subnet-az1" {
vpc_id = "${aws_vpc.custom_vpc.id}"
availability_zone = "${var.primary_az}"
cidr_block = "10.0.101.0/24"
tags {
Name = "app-subnet-1"
}
}

resource "aws_subnet" "pri-app-subnet-az2" {
vpc_id = "${aws_vpc.custom_vpc.id}"
availability_zone = "${var.secondary_az}"
cidr_block = "10.0.102.0/24"
tags {
Name = "app-subnet-2"
}
}
########### db subnet #########
resource "aws_subnet" "pri-db-subnet-az1" {
vpc_id = "${aws_vpc.custom_vpc.id}"
availability_zone = "${var.primary_az}"
cidr_block = "10.0.201.0/24"
tags {
Name = "db-subnet-1"
}
}

resource "aws_subnet" "pri-db-subnet-az2" {
vpc_id = "${aws_vpc.custom_vpc.id}"
availability_zone = "${var.secondary_az}"
cidr_block = "10.0.202.0/24"
tags {
Name = "db-subnet-2"
}
}

################### internet gateway ###########

resource "aws_internet_gateway" "igw" {
vpc_id = "${aws_vpc.custom_vpc.id}"
}


###### NAT gw ##########

resource "aws_eip" "nat_eip" {
vpc = "true"
}

resource "aws_nat_gateway" "gw" {
    allocation_id = "${aws_eip.nat_eip.id}"
    subnet_id = "${aws_subnet.pri-db-subnet-az1.id}"
	subnet_id = "${aws_subnet.pri-db-subnet-az2.id}"
	depends_on = ["aws_internet_gateway.igw"]
}

############## route table defination ###########

##### public route table #########


resource "aws_route_table" "public_rt" {
vpc_id = "${aws_vpc.custom_vpc.id}"

route {
cidr_block = "0.0.0.0/0"
gateway_id = "${aws_internet_gateway.igw.id}"
}

tags {
Name = "public_rt"
}
}


############# route table association #########

resource "aws_route_table_association" "pub_rt_ass" {
subnet_id = "${aws_subnet.pub-subnet-az1.id}"
subnet_id = "${aws_subnet.pub-subnet-az2.id}"
route_table_id = "${aws_route_table.public_rt.id}"
}


 
 ####### private route table ############
 
resource "aws_route_table" "pri_rt" {
vpc_id = "${aws_vpc.custom_vpc.id}"
tags {
Name = "pri_rt"
}
}

###################################private route association ##############

resource "aws_route_table_association" "pri_rt_ass" {
subnet_id = "${aws_subnet.pri-db-subnet-az1.id}"
#subnet_id = "${aws_subnet.pri-db-subnet-az2.id}"
#subnet_id = "${aws_subnet.pri-app-subnet-az1.id}"
#subnet_id = "${aws_subnet.pri-app-subnet-az2.id}"
route_table_id = "${aws_route_table.pri_rt.id}"
}




#################

#################


