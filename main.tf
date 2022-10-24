provider "aws" {
  region = "us-east-2"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "nome_do_recurso_terraform" {
    count = 2
  ami = "ami-097a2df4ac947655f"
  instance_type = "t2.micro"
  key_name = "nidio-terraform-aws"
  tags = {
    "Name" = "nidio-${count.index}"
  }
}

resource "aws_key_pair" "nidio_terraform_key" {
key_name = "nidio-terraform-aws"
public_key = file("terraform-aws.pub")
  
}
# terraform init - baixar os modulos do terraform baseado nos seus arquivos
# terraform plan - mostrar o plano a ser feito
# terraform apply - vai aplicar o plano ou seja vai contruir tudo se não tiver erro
# terraform destroy - acabou, já era boa sorte
# terraform output - mostra as saidas do output
# terraform show - mostra como está a sua infra