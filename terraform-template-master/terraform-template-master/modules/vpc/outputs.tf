output  "vpc_id" {
value = "${aws_vpc.custom_vpc.id}"
}
output "web-subnets-az1" {
  value = "${aws_subnet.pub-subnet-az1.0.id}"
}

output "web-subnets-az2" {
  value = "${aws_subnet.pub-subnet-az1.1.id}"
}
output "lazypay-sg" {
value = "${aws_security_group.laypay-sg.id}"
}


output "app-subnets-az1" {
  value = "${aws_subnet.app-subnet-az1.0.id}"
}

output "app-subnets-az2" {
  value = "${aws_subnet.app-subnet-az1.1.id}"
}


output "db-subnets-az1" {
  value = "${aws_subnet.db-subnet-az1.0.id}"
}

output "db-subnets-az2" {
  value = "${aws_subnet.db-subnet-az1.1.id}"
}

