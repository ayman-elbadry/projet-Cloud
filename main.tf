terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1" 
}

resource "aws_security_group" "k8s_sg" {
  name        = "k8s_security_group"
  description = "Autoriser SSH, HTTP, et K8s"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 30001
    to_port     = 30001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Machine 1: Master Node
resource "aws_instance" "master_node" {
  ami             = "ami-0989fb15ce71ba39e" # Image Ubuntu 22.04 LTS f eu-north-1
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.k8s_sg.name]
  key_name        = "projet-devops-key"

  tags = {
    Name = "K8s-Master"
  }
}

# Machine 2: Worker Node
resource "aws_instance" "worker_node" {
  ami             = "ami-0989fb15ce71ba39e"
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.k8s_sg.name]
  key_name        = "projet-devops-key"

  tags = {
    Name = "K8s-Worker"
  }
}