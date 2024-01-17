terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.1"
    }

    aap = {
      source = "ansible/aap"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "created-by-terraform-3" {
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
  tags = {
    Name = "created-by-terraform-3"
  }
}

resource "aws_instance" "created-by-terraform-4" {
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
  tags = {
    Name = "created-by-terraform-4"
  }
}

provider "aap" {
  host     = "https://localhost:8043"
  username = "ansible"
  password = "test123!"
  insecure_skip_verify = true
}

resource "aap_host" "instance-3" {
  inventory_id = 2
  name = "created-by-terraform-3"
  description = "An EC2 instance created by Terraform"
  variables = jsonencode(aws_instance.created-by-terraform-3)
}

resource "aap_host" "instance-4" {
  inventory_id = 2
  name = "created-by-terraform-4"
  description = "Another EC2 instance created by Terraform"
  variables = jsonencode(aws_instance.created-by-terraform-4)
}

output "instance-3" {
  value = aap_host.instance-3
}

output "instance-4" {
  value = aap_host.instance-4
}
