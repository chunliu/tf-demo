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
  access_key    = var.ak  # Provide your BytePlus access key
  secret_key    = var.sk  # Provide your BytePlus secret key
  region        = "ap-southeast-1"
  endpoint      = "open.ap-southeast-1.byteplusapi.com"
}
