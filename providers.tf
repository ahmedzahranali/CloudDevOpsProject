terraform {
  required_version = ">= 1.0.0"
  required_providers {
  aws = {
    source = "hashicorp/aws"
    version = "~> 5.0"
   }
  }

  backend "s3" {
    bucket         = "arn:aws:s3:::cloud-devops-project-862264091652-us-east-2-an"
    key            = "devops-project/terraform.tfstate"
    region         = "us-east-1"

  }
}

provider "aws" {
  region = 
}
