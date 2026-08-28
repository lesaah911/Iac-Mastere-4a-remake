variable "vpc_id" {
  type = string
}

variable "prefix" {
  type = string
}

# TYPE COMPOSE
variable "ingress_rules" {
  type = list(object({
    description = string
    from_port = number
    to_port = number
    protocol = string
    cidr_block= list(string)
  }))
}
  variable "tags" {
    type = map(string)
  }
