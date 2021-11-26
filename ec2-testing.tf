/*
resource "aws_instance" "myEC2" {
  ami = "ami-0c0a1cc13a52a158f" # UBUNTU - ssh user is "ubuntu"
  #LINUX2 AMI's user is ec2-user
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.private[0].id
  key_name                    = "ec2-instance"
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.ssh-allowed.id]

  //passing user data to the instance 
  //that can be used to perform common automated 
  //configuration tasks and even run scripts after the instance starts. 
    user_data = <<-EOF
        #!/bin/bash   
        sudo bash -c "echo 'ec2-user:1234567890' | chpasswd"
    EOF
  #-y argument overrides the y/n question of apt-get
}

resource "aws_instance" "myEC2-1" {
  ami = "ami-0c0a1cc13a52a158f" # UBUNTU - ssh user is "ubuntu"
  #LINUX2 AMI's user is ec2-user
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public[0].id
  key_name                    = "ec2-instance"
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.ssh-allowed.id]

  //passing user data to the instance 
  //that can be used to perform common automated 
  //configuration tasks and even run scripts after the instance starts. 
    user_data = <<-EOF
        #!/bin/bash   
        sudo bash -c "echo 'ec2-user:1234567890' | chpasswd"
    EOF
  #-y argument overrides the y/n question of apt-get
}
*/