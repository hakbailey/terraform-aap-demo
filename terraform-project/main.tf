terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.1"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "created-by-terraform" {
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
  tags = {
    Name = "created-by-terraform"
  }
}
