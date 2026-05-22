def call(String imageName) {
  echo "Cleaning up local Docker image: ${imageName}"
  sh "docker rmi ${imageName}"
}
