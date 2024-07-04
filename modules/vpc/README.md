## AWS Networking Resources Configuration

### Resource: aws_vpc

- **cidr_block**: Defines the CIDR block for the VPC.
    - **Value**: `var.vpc_cidr_block` sets the IP range for the VPC.
- **enable_dns_support**: Specifies whether to enable DNS support.
    - **Value**: `true` enables DNS resolution within the VPC.
- **enable_dns_hostnames**: Specifies whether to enable DNS hostname support.
    - **Value**: `true` allows instances in the VPC to receive a DNS hostname.

### Resource: aws_internet_gateway

- **vpc_id**: Links the internet gateway to a specific VPC.
    - **Value**: `aws_vpc.vpc.id` refers to the ID of the previously defined VPC.

### Resource: aws_route_table

- **vpc_id**: Associates the route table with a specific VPC.
    - **Value**: `aws_vpc.vpc.id` connects the route table to the VPC.
- **route**: Defines routing rules for the route table.
    - **cidr_block**: Sets the destination CIDR block for the route.
        - **Value**: `"0.0.0.0/0"` routes all traffic.
    - **gateway_id**: Specifies the gateway through which to route traffic.
        - **Value**: `aws_internet_gateway.internet_gateway.id` directs all traffic through the internet gateway.

### Resource: aws_route_table_association

- **subnet_id** and **route_table_id**: Links subnets to the route table.
    - **Value** (subnet_route_1): `aws_subnet.subnet_public_1.id` and `aws_route_table.route_table.id`.
    - **Value** (subnet_route_2): `aws_subnet.subnet_public_2.id` and `aws_route_table.route_table.id`.

### Resource: aws_security_group

- **vpc_id**: Associates the security group with a specific VPC.
    - **Value**: `aws_vpc.vpc.id` connects the security group to the VPC.
- **ingress** and **egress**:
    - **from_port** and **to_port**: Defines the port range.
        - **Value**: `0` to `0` indicates all ports.
    - **protocol**: Specifies the protocol.
        - **Value**: `"-1"` allows all protocols.
    - **cidr_blocks**: Defines which IP ranges are allowed to access.
        - **Value**: `"0.0.0.0/0"` allows all IP addresses.
    - **description**: Provides a description of the rule.
        - **Ingress**: `"Allow all inbound traffic"`.
        - **Egress**: `"Allow all outbound traffic"`.

### Data Source: aws_availability_zones

- Fetches the list of available availability zones.

### Resource: aws_subnet

- **vpc_id**: Links each subnet to the specified VPC.
- **cidr_block**: Specifies the CIDR block for each subnet.
- **availability_zone**: Assigns each subnet to a specific availability zone.
- **map_public_ip_on_launch**: Determines whether instances launched in these subnets receive a public IP.
    - **Value**: `var.map_public_ips` decides this setting based on a variable.
