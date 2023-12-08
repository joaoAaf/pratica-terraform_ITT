resource "aws_instance" "ativ-pratica-tf" {
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
    destination = "/tmp/"
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
    private_key = file("/home/$USER/.ssh/itt-keys.pem")
    host = self.public_ip
  }
}
