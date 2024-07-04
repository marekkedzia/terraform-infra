output "task_image" {
  value = "${aws_ecr_repository.repository.repository_url}:main"
}
