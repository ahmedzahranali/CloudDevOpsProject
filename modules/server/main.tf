resource "aws_iam_role" "jenkins_ssm_role" {
  name = "devops-project-jenkins-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Princioal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "jenkins_ssm_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role = aws_iam_role.jenkins_ssm_role.name
}

resource "aws_iam_instance_profile" "jenkins_ssm_profile" {
  name = "devops-projrct-jenkins-ssm-profile"
  role = aws_iam_role.jenkins_ssm_role.name
}

resource "aws_security_group" "jenkins_sg" {
  name = "jenkins-server-sg"
  description = "Allow web and SSH traffic to jenkins"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow Jenkins Web UI"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH management"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DevOps-Project-Jenkins-SG"
  }
}

resource "aws_instance" "jenkins" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t3.medium"
  subnet_id = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  iam_instance_profile = aws_iam_instance_profile.jenkins_ssm_profile.name

  tags = {
    Name = "DevOps-Project-Jenkins-Server"
  }
}
