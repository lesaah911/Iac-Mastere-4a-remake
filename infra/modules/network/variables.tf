variable "vpc_id" {
  type = string
}

variable "prefix" {
  type = string
}

# TYPE COMPOSE
variable "subnets" {
  type = map(object({
    cidr = string
    map_public_ip_on_launch = bool
  }))
}

variable "tags" {
  type = map(string)
}