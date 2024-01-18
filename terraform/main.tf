terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.1"
    }

    google = {
      source = "hashicorp/google"
      version = "5.12.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "tf-demo-aws-ec2-instance-1" {
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
  tags = {
    Name = "tf-demo-aws-ec2-instance-1"
  }
}

variable "gcp_credentials_path" { type= string }
variable "gcp_project" { type= string }

provider "google" {
  credentials = var.gcp_credentials_path
  project = var.gcp_project
  region = "northamerica-northeast1"
}

resource "google_compute_instance" "tf-demo-gcp-instance-1" {
  name         = "tf-demo-gcp-instance-1"
  machine_type = "e2-micro"
  zone = "northamerica-northeast1-a"

  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20240110"
      labels = {
        my_label = "value"
      }
    }
  }

network_interface {
    network = "default"
  }
}
