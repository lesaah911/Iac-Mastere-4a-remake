output "subnet_ids" {
  description = "map(nom_subnet => id)"
  value = {for k, s in aws_subnet.net_saah : k => s.id}
}