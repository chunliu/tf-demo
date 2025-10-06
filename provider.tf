terraform {
  required_providers {
    byteplus = {
      source = "byteplus-sdk/byteplus"
      version = "0.0.22"
    }
  }
}

# Configure the Byteplus Provider
provider "byteplus" {
  access_key    = var.ak
  secret_key    = var.sk
  region        = "ap-southeast-1"
  endpoint      = "open.ap-southeast-1.byteplusapi.com"
}
