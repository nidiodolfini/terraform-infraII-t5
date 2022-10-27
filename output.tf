output "instancias_ec2" {
  value = aws_instance.nidio_ec2.*.public_ip
}
output "instancias_ec2_private" {
  value = aws_instance.nidio_ec2.*.private_ip
}