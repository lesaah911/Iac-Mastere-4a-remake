resource "aws_key_pair" "kp_saah" {
  key_name = "${var.prefix}-key"
  public_key = file(pathexpand(var.public_key_path))
}

resource "aws_instance" "vm_saah" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.sg_ids
  key_name = aws_key_pair.kp_saah.key_name

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = merge(var.tags, { Name = "${var.prefix}-vm"})
}

# ELASTIC IP

resource "aws_eip" "eip_saah" {
  instance = aws_instance.vm_saah.id
  domain = "vpc"
  tags = merge(var.tags, {Name = "${var.prefix}-eip"})
}

# AUTOMATISATION TERRAFORM
# TERRAFORM GENERE LUI MEME L'INVENTAIRE
resource "local_file" "ansible_inventory" {
  filename = var.inventory_output_path
  file_permission = "0644"

  content = templatefile("${path.module}/templates/inventory.tpl",{
    host = aws_eip.eip_saah.public_ip
    ssh_user = var.ssh_user
    ssh_private_key = var.ssh_private_key_path
  })
}