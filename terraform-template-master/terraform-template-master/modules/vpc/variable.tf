variable "project" {} 
variable "cidr" {}

variable "azs" { 
default = []
}
variable "web-subnet" {
default = []
}
variable "app-subnet" {
default = []
}
variable "db-subnet" {
default = []
}
