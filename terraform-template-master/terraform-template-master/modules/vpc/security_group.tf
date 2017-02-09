resource "aws_security_group" "laypay-sg" {
name = "lazypay-sg"
description = "security group of lazypay"
vpc_id = "${aws_vpc.custom_vpc.id}"
ingress {
from_port = 0
to_port = 0
cidr_blocks = ["0.0.0.0/0"]
protocol = "-1"
       }
egress {
from_port = 0
to_port = 0
cidr_blocks = ["0.0.0.0/0"]
protocol = "-1"
}
tags {
Name =  "lazypay-sg"
     }
}
