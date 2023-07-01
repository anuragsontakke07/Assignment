terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.6.1"
    }
  }
  
  backend "s3" {
   bucket = "s3-upgrad-assignment"
   key = "states/terraform.tfstate"
   region = "us-east-1"
 }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}