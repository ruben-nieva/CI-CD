resource "aws_instance" "example" {
ami   = "ami-6a3ae60a"

instance_type = "t2.micro" 

root_block_device {
volume_type = "gp2"

volume_size = "30"
}
}

