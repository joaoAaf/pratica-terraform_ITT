provider "aws" {
  shared_config_files      = ["/home/$USER/.aws/config"]
  shared_credentials_files = ["/home/$USER/.aws/credentials"]
}

resource "aws_instance" "pratica-tf-2" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "itt-keys"
  vpc_security_group_ids = ["sg-051e34146616a7798", "sg-0ab4589c664938387", "sg-01033e2f069124087"]
  tags = {
    Name = "pratica-tf-2"
  }
  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install nginx -y
    EOF
}
