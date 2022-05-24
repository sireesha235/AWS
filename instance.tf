#Create EC2 Instance
resource "aws_instance" "Application1" {
  ami                    = "ami-0d5eff06f840b45e9"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.alb_sg.id]
  subnet_id              = aws_subnet.private_subnet-1.id
  user_data              = file("install_apache.sh")

  tags = {
    Name = "Application_1"
  }

}

resource "aws_instance" "Application2" {
  ami                    = "ami-0d5eff06f840b45e9"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1b"
  vpc_security_group_ids = [aws_security_group.alb_sg.id]
  subnet_id              = aws_subnet.private_subnet-2.id
  user_data              = file("install_apache.sh")

  tags = {
    Name = "Application_2"
  }

}
