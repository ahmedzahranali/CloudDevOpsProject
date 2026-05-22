def call(Stgring manifestPath, stringnewImageName) {
  echo "Updating Kubernetes manifest with new image tag: ${newImageName}"
  sh "sed -i 's|image: .*image: ${newImageName}|g' ${manifestPath}"
}
