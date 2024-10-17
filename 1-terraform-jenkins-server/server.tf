# Fetch the latest Ubuntu 24 AMI owned by Canonical
data "aws_ami" "latest-ubuntu-24-image" {
  most_recent = true
  owners      = ["0007c762ce4381a3f"]  # Canonical's AWS Account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Define the Jenkins server
resource "aws_instance" "jenkins-server" {
  # Specify the AMI id defined above
  ami                         = data.aws_ami.latest-amazon-linux-image.id
  instance_type               = var.instance_type
  key_name                    = "jenkins-server-demo"
  subnet_id                   = aws_subnet.jenkins-subnet-1.id
  vpc_security_group_ids      = [aws_default_security_group.jenkins-sg.id]
  availability_zone           = var.availability_zone
  associate_public_ip_address = true
  # Specify a script to be executed when the instance is launched
  user_data                   = file("jenkins-script.sh")
  tags = {
    Name = "${var.env_prefix}-server"
  }
}
