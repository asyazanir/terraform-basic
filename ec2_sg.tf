## sg_i2go.tf
## aws_security_group.security_group
## aws_security_group_rule.security_group_egress
## aws_security_group_rule.security_group_ingress_80
## aws_security_group_rule.security_group_ingress_443
## aws_security_group_rule.security_group_ingress_22


resource "aws_security_group" "security_group" {
  vpc_id      = aws_vpc.vpc.id
  name        = var.security_group_name
  description = var.security_group_description
  tags = {
    Name = "Security Group"
  }
}

resource "aws_security_group_rule" "security_group_egress" {
  security_group_id = aws_security_group.security_group.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.egressCIDRblock
}

resource "aws_security_group_rule" "security_group_ingress_80" {
  security_group_id = aws_security_group.security_group.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.ingressCIDRblock
}

resource "aws_security_group_rule" "security_group_ingress_443" {
  security_group_id = aws_security_group.security_group.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.ingressCIDRblock
}

resource "aws_security_group_rule" "security_group_ingress_22" {
  security_group_id = aws_security_group.security_group.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.ingressCIDRblock
}


