resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "myigw"
  }
}

