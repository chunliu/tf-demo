resource "byteplus_vpc" "tf_vpc" {
  vpc_name   = "tf-vke-vpc"
  cidr_block = "172.16.0.0/16"
}

resource "byteplus_subnet" "tf_subnet1" {
  subnet_name = "tf-vke-subnet1"
  cidr_block  = "172.16.0.0/24"
  zone_id     = "ap-southeast-1a"
  vpc_id      = byteplus_vpc.tf_vpc.id
}

resource "byteplus_subnet" "tf_subnet2" {
  subnet_name = "tf-vke-subnet2"
  cidr_block  = "172.16.1.0/24"
  zone_id     = "ap-southeast-1a"
  vpc_id      = byteplus_vpc.tf_vpc.id
}
