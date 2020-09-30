# Creating Security Group
resource "aws_security_group" "AllowWebServicesAndSSH" {
  name        = "AllowWebServicesAndSSH"
  description = "Allow webservices and ssh inbound traffic"
  vpc_id = aws_vpc.main_vpc.id
  # allow ingress of port 80
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # allow ingress of port 22
  ingress { 
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AllowWebServicesAndSSH"
  }
}