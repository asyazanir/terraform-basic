## ec2_eip.tf
## aws_eip.eip
## aws_eip_association.i2go
## aws_eip.rating
## aws_eip_association.rating

resource "aws_eip" "eip" {
  tags = {
    Name = "Elastic IP"
  }
}

resource "aws_eip_association" "eip" {
  instance_id   = aws_instance.ec2.id
  allocation_id = aws_eip.eip.id
}
