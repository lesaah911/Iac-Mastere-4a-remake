variable "region" {
  type    = string
  default = "us-east-1"
}

variable "username" {
  type = string
}

variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment doit etre dev, staging ou prod."
  }
}

variable "vpc_id" {
  type = string
}

# TYPE COMPOSE : map(object)
variable "subnets" {
  type = map(object({
    cidr                    = string
    map_public_ip_on_launch = bool
  }))
}

# TYPE COMPOSE : list(object)
variable "ingress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

# TYPE COMPOSE : object
variable "instance_config" {
  type = object({
    instance_type = string
    ami_owner     = string
    ami_name      = string
  })
}

# TYPE COMPOSE : map(string)
variable "common_tags" {
  type = map(string)
}

variable "public_key_path" {
  type = string
}

variable "ssh_private_key_path" {
  type = string
}

variable "ssh_user" {
  type    = string
  default = "ubuntu"
}
