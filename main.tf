provider "aws" {
    region = "us-west-1"
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners = [ "amazon" ]

  #Found via aws ec2 describe-images --region us-west-1 --image-ids CLI
  filter {
    name = "name"
    values = ["al2023-ami-2023.12.20261016.*-kernel-6.18-x86_64"]
  }

  filter {
    name = "free-tier-eligible"
    values = ["true"]
  }
}

resource "aws_instance" "free_tier_instance" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"

  tags = {
    Name = "free-tier"
  }
}