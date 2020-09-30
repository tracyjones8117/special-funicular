# Creating Security Group
resource "aws_security_group" "AllowSQLandSSH" {
  name        = "AllowSQLandSSH"
  description = "AllowSQLandSSH"
  vpc_id = aws_vpc.main_vpc.id

  # allow ingress of port 22
  ingress { 
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  } 
  ingress { 
    description = "Allow SQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AllowSQLandSSH"
  }
}