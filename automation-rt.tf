resource "aws_default_route_table" "week4" {
  default_route_table_id = aws_vpc.main.default_route_table_id
  #  vpc_id = aws_vpc.main.id

  route = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.gw.id

      egress_only_gateway_id     = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      nat_gateway_id             = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      local_gateway_id           = ""
    },
  ]
  tags = {
    Name = "automation-rt"
  }
}
