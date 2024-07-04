output "vpc_id" { value = aws_vpc.vpc.id }
output "subnet_public_ids" { value = [aws_subnet.subnet_public_1.id, aws_subnet.subnet_public_2.id] }
output "security_group_id" { value = aws_security_group.security_group.id }
