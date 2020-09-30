resource "aws_instance" "webserver" {
  ami           = "ami-005956c5f0f757d37"
  instance_type = "t2.micro"
  key_name = aws_key_pair.generated_key.key_name
  security_groups = [ aws_security_group.AllowWebServicesAndSSH.id ]
  subnet_id   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  depends_on = [ aws_instance.SQLserver]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = tls_private_key.createkey.private_key_pem
    host     = aws_instance.webserver.public_ip
  }

  provisioner "remote-exec" {
    inline = [
    "sudo yum update -y",
    "sudo yum install git -y",
    "sudo yum install docker -y",
    "sudo service docker start",
    "sudo usermod -a -G docker ec2-user",
    "sudo docker run --name wordpress -e WORDPRESS_DB_HOST=${aws_instance.SQLserver.private_ip} -e WORDPRESS_DB_USER=wordpress -e WORDPRESS_DB_PASSWORD=gurpreet  -e WORDPRESS_DB_NAME=wordpressdb -d -p 80:80 wordpress",
    "mkdir webserver_code"
    ]
  }

  tags = {
    Name = "Webserver"
  }

}

output "PublicIP" {
    depends_on = [ aws_instance.webserver]
   value = "The Public IP of Webserver is ${aws_instance.webserver.public_ip} "
}