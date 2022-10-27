resource "aws_instance" "nidio_ec2" {
  count         = 1
  ami           = var.ami
  instance_type = var.tipo_instancia
  key_name      = "${var.usuario}-terraform-aws"
  tags = {
    "Name" = "${var.usuario}-ec2-${count.index}"
  }
  vpc_security_group_ids = [ aws_security_group.sg_acesso_ssh_publico.id, aws_security_group.sg_acesso_web.id ]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y \
    ca-certificates -y \
    curl -y \
    gnupg -y \
    lsb-release -y
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
        
    EOF
}
