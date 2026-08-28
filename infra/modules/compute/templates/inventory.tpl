# Fichier genere automatiquement par Terraform (local_file + templatefile())
# a chaque "make build" - ne pas editer a la main.
[web]
${host} ansible_user=${ssh_user} ansible_ssh_private_key_file=${ssh_private_key}

[web:vars]
ansible_python_interpreter=/usr/bin/python3