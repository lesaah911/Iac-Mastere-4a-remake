variable "prefix" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "sg_ids" {
  type = list(string)
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "public_key_path" {
  type = string
}

variable "ssh_user" {
  type = string
}

variable "ssh_private_key_path" {
  type = string
}

variable "inventory_output_path" {
  description = "Chemin du fichier inventory.ini genere pour Ansible"
  type = string
}

variable "tags" {
  type = map(string)
}