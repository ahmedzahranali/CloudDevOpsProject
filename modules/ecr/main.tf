resource "aws_ecr_repository" "app_repo" {
  name = "devops-portfolio-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "DevOps-Project-ECR-Repo"
  }
}

output "repository_url" {
  value = aws_ecr_repository.app_repo.repository_url
}
