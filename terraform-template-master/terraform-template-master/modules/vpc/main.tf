resource "aws_vpc" "custom_vpc" {
tags {

Name = "${var.project}"
}
cidr_block = "${var.cidr}"
}

######### web subnet defination ###########
resource "aws_subnet" "pub-subnet-az1" {
vpc_id = "${aws_vpc.custom_vpc.id}"
availability_zone = "${var.azs[count.index]}"
cidr_block = "${var.web-subnet[count.index]}"
count             = "${length(var.web-subnet)}"
tags {
Name = "${var.project}-web-subnet"
}
}


resource "aws_subnet" "app-subnet-az1" {
vpc_id = "${aws_vpc.custom_vpc.id}"
availability_zone = "${var.azs[count.index]}"
cidr_block = "${var.app-subnet[count.index]}"
count             = "${length(var.app-subnet)}"
tags {
Name = "${var.project}-app-subnet"
}
}




resource "aws_subnet" "db-subnet-az1" {
vpc_id = "${aws_vpc.custom_vpc.id}"
availability_zone = "${var.azs[count.index]}"
cidr_block = "${var.db-subnet[count.index]}"
count             = "${length(var.db-subnet)}"
tags {
Name = "${var.project}-db-subnet"
}
}



################### internet gateway ###########

resource "aws_internet_gateway" "igw" {
vpc_id = "${aws_vpc.custom_vpc.id}"
}


###### NAT gw ##########


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
count          = "${length(var.web-subnet)}"
subnet_id      = "${element(aws_subnet.pub-subnet-az1.*.id, count.index)}"
route_table_id = "${aws_route_table.public_rt.id}"
}




resource "aws_route_table_association" "app_pub_rt_ass" {
count          = "${length(var.web-subnet)}"
subnet_id      = "${element(aws_subnet.app-subnet-az1.*.id, count.index)}"
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
count          = "${length(var.app-subnet)}"
subnet_id      = "${element(aws_subnet.db-subnet-az1.*.id, count.index)}"
route_table_id = "${aws_route_table.pri_rt.id}"
}




#################

#################
