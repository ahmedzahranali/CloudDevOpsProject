def call(String manifestPath, String buildNumber) {
  echo "Commiting updated manifests to Git repository"
  sh """
  git config --global user.email "jenkins@mydevopsresume.com"
  git config --global user.name "Jenkins CI"
  git add ${manifestPath}
  git commit -m "Updated k8s deployment image to tag ${buildNumber} [skip ci]"
  git push origin HEAD:main
  """
}
