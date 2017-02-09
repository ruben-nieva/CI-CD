module "new-vpc" {
source  = "./module"
project = "lazypay"
azs = ["us-east-1a", "us-east-1b"]
cidr = "10.0.0.0/16"
web-subnet = ["10.0.1.0/28", "10.0.101.0/28"]
app-subnet = ["10.0.2.0/28", "10.0.201.0/28"]
db-subnet = ["10.0.4.0/28", "10.0.5.0/28"]

} 
