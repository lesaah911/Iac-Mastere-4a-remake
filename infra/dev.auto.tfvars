
region      = "us-east-1"
username    = "emeric"
environment = "dev"

vpc_id = "vpc-0d2494c176de7a66e"

subnets = {
  public = {
    cidr                    = "10.0.1.0/24"
    map_public_ip_on_launch = true
  }
}

ingress_rules = [
  { description = "SSH",         from_port = 22,   to_port = 22,   protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
  { description = "HTTP nginx",  from_port = 80,   to_port = 80,   protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
  { description = "HTTP docker", from_port = 8080, to_port = 8080, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
]

instance_config = {
  instance_type = "t2.micro"
  ami_owner     = "099720109477"
  ami_name      = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
}

common_tags = {
  Project = "iac-mastere-4a-remake"
  Owner   = "emeric"
  Managed = "terraform"
}

public_key_path      = "~/.ssh/iac_remake.pub"
ssh_private_key_path = "~/.ssh/iac_remake"
ssh_user              = "ubuntu"