
resource "aws_subnet" "net_saah" {
  for_each = var.subnets
  vpc_id = var.vpc_id
  cidr_block = each.value.cidr
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = merge(var.tags, { Name = "${var.prefix}-${each.key}"})
}