resource "aws_instance" "SQLserver" {
  ami           = "ami-0d39db4976f3fce89"
  instance_type = "t2.micro"
  key_name = aws_key_pair.generated_key.key_name
  security_groups = [ aws_security_group.AllowSQLandSSH.id ]
  associate_public_ip_address = false 
  subnet_id = aws_subnet.private_subnet.id
  tags = {
    Name = "SQLserver"
  }

}