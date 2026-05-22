def call(String imageName) {
  echo "Scaning Docker Image with Trivy: ${imageName}"
  sh "trivy image --severity CRITICAL --exit-code 1 ${imageName}"
}
