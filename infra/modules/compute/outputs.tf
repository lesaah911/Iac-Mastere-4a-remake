output "public_ip" {
  value = aws_eip.eip_saah
}

output "instance_id" {
  value = aws_instance.vm_saah.id
}