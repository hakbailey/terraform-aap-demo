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

resource "aws_instance" "created-by-terraform-1" {
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
  tags = {
    Name = "created-by-terraform-1"
  }
}

resource "aws_instance" "created-by-terraform-2" {
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
  tags = {
    Name = "created-by-terraform-2"
  }
}

provider "aap" {
  host     = "https://localhost:8043"
  username = "ansible"
  password = "test123!"
  insecure_skip_verify = true
}

resource "aap_host" "instance-1" {
  inventory_id = 2
  name = aws_instance.created-by-terraform-1.id
  description = "An EC2 instance created by Terraform"
  variables = jsonencode(aws_instance.created-by-terraform-1)
}

resource "aap_host" "instance-2" {
  inventory_id = 2
  name = aws_instance.created-by-terraform-2.id
  description = "Another EC2 instance created by Terraform"
  variables = jsonencode(aws_instance.created-by-terraform-2)
}

output "instance-1" {
  value = aap_host.instance-1
}

output "instance-2" {
  value = aap_host.instance-2
}
