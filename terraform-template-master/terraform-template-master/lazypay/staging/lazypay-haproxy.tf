resource "aws_instance" "haproxy-1" {
ami   = "ami-17d88600"
subnet_id = "${module.new-vpc.web-subnets-az1}" 
instance_type = "t2.micro" 

tags {
Name = "lazypay-haproxy-1"
}
vpc_security_group_ids = ["${module.new-vpc.lazypay-sg}"]
#vpc_security_group_ids = ["sg-0fb55876"]
key_name = "lazypay-key"
associate_public_ip_address = 1
user_data = "${file("userdata.sh")}"
root_block_device {
volume_type = "gp2"
volume_size = "30"
}
}

resource "aws_instance" "haproxy-2" {
ami   = "ami-17d88600"
subnet_id = "${module.new-vpc.web-subnets-az2}"
instance_type = "t2.micro"

tags {
Name = "lazypay-haproxy-2"
}
vpc_security_group_ids = ["${module.new-vpc.lazypay-sg}"]
#vpc_security_group_ids = ["sg-0fb55876"]
key_name = "lazypay-key"
associate_public_ip_address = 1
user_data = "${file("userdata.sh")}"
root_block_device {
volume_type = "gp2"
volume_size = "30"
}
}
