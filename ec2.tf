resource "aws_instance" "ec2-pratica-tf" {
  count                  = 2
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "itt-keys"
  vpc_security_group_ids = ["sg-051e34146616a7798", "sg-0ab4589c664938387", "sg-01033e2f069124087"]
  tags = {
    Name = "ativ-pratica-tf"
  }
  provisioner "file" {
    source = "configNginx.sh"
    destination = "/tmp/configNginx.sh"
  }
  provisioner "remote-exec" {
    inline = [ 
        "sudo chmod +x /tmp/configNginx.sh",
        "sudo /tmp/configNginx.sh",
    ]
  }
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/.ssh/itt-keys.pem")
    host = self.public_ip
  }
}
output "ec2-pratica-tf" {
  value = aws_instance.ec2-pratica-tf[0].public_dns
}