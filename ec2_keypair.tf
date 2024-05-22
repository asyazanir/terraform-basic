## ec2_keypair.tf
## ├─ aws_key_pair.keypair

resource "aws_key_pair" "keypair" {
  key_name   = var.key_name
  public_key = var.public_key
}