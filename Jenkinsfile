pipeline {
  agent any 

  environment {
      AWS_REGION = 'us-east-1'
      AWS_ACCOUNT = credentials('aws-account-id')
      ECR_REGISTRY = '${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com'
      ECR_REPO = 'ivolve-ecr-repo'
      IMAGE_TAG = "v1.0.${env.BUILD_NUMBER}"
      IMAGE_NAME = "${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG}"
      DEPLOY_FILE = "k8s/deployment.yaml"
  }

stages {
        stage('Build Image') {
            steps {
                script {
                    buildImage(env.IMAGE_NAME)
                }
            }
        }

        stage('Scan Image') {
            steps {
                script {
                    scanImage(env.IMAGE_NAME)
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    pushImage(env.AWS_REGION, env.ECR_REGISTRY, env.IMAGE_NAME)
                }
            }
        }

        stage('Delete Image Locally') {
            steps {
                script {
                    deleteLocalImage(env.IMAGE_NAME)
                }
            }
        }

        stage('Update Manifests') {
            steps {
                script {
                    updateManifests(env.DEPLOY_FILE, env.IMAGE_NAME)
                }
            }
        }

        stage('Push Manifests') {
            steps {
                script {
                    withCredentials([gitUsernamePassword(credentialsId: 'github-credentials-id', gitToolName: 'Default')]) {
                        pushManifests(env.DEPLOY_FILE, env.BUILD_NUMBER)
                    }
                }
            }
        }
    }
}
