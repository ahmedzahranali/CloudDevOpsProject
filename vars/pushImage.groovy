def call(String awsRegion, String ecrRegistry, String imageName) {
  echo "Pushing Image to ECR: ${imageName}"
  sh """
  aws ecr get-login-password --region ${awsRegion} | docker login --username AWS --pasword-stdin ${ecrRegistry} docker push ${imageName}"""
}
