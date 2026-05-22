def call(String imageName) {
  echo "Building Docker Image: ${imageName}"
  sh "docker build -t ${imageName}"
}
