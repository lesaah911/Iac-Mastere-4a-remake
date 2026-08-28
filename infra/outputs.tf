output "public_ip" {
  value = module.compute.public_ip
}

output "ssh_command" {
  value = "ssh -i ${var.ssh_private_key_path} ${var.ssh_user}@${module.compute.public_ip}"
}

output "web_urls" {
  value = {
    apt_nginx    = "http://${module.compute.public_ip}"
    docker_nginx = "http://${module.compute.public_ip}:8080"
  }
}