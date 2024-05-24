## ec2.tf
## aws_instance.ec2

resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [
    aws_security_group.security_group.id
  ]
  subnet_id         = aws_subnet.subnet_public_1a.id
  availability_zone = var.azs_1a
  tags = {
    Name = "ec2"
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    encrypted             = true
    tags = {
      Name = "ec2 EBS"
    }
  }
}
