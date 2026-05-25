# Cloud DevOps Project: End-to-End DevSecOps & GitOps Architecture

**Author:** Ahmed Zahran Ali Zahran  
**Repository:** https://github.com/ahmedzahranali/CloudDevOpsProject

---

## 🏛️ Architecture Overview

This project demonstrates a production-ready, automated cloud architecture on AWS. It integrates a comprehensive DevSecOps workflow, encompassing Infrastructure as Code (IaC), containerization, configuration management, and GitOps-driven CI/CD pipelines.

### 1. Application Containerization
*   **Source Code:** Built using the application source code from [IbrahimAdel15/FinalProject](https://github.com/IbrahimAdel15/FinalProject.git).
*   **Docker:** A custom `Dockerfile` is utilized to package the application securely into a portable container image.

### 2. Infrastructure as Code (Terraform)
*   **State Management:** Securely managed using an S3 backend.
*   **Network Module:** Provisions a custom VPC, public and private subnets, an Internet Gateway (IGW), NAT Gateways, and Network ACLs.
*   **Server Module:** Deploys an EC2 instance dedicated to Jenkins, secured with strict Security Groups.
*   **EKS Module:** Provisions an Elastic Kubernetes Service (EKS) cluster with two worker nodes distributed across different private subnets and Availability Zones for high availability.
*   **ECR Module:** Creates an Elastic Container Registry (ECR) to store the built Docker images securely.

### 3. Configuration Management (Ansible)
*   **Roles:** Utilizes modular Ansible roles to systematically configure the Jenkins EC2 instance.
*   **Dependencies:** Automates the installation of Java, Jenkins, Docker, and the Trivy vulnerability scanner.
*   **Dynamic Inventory:** Employs an AWS dynamic inventory script to securely discover and connect to the Jenkins server without hardcoding IP addresses.

### 4. Container Orchestration (Kubernetes)
*   **Namespace:** All resources are isolated within the `ivolve` namespace.
*   **Deployment:** Runs two replicas of the application. High availability is enforced using Pod Anti-Affinity rules to guarantee each replica is scheduled on a separate worker node.
*   **Networking:** Utilizes a Kubernetes Service and an Ingress resource to route external traffic securely to the application pods.

### 5. Continuous Integration (Jenkins CI)
*   **Pipeline as Code:** Orchestrated via a `Jenkinsfile`.
*   **Shared Library:** Abstracted pipeline logic utilizing a custom Groovy shared library stored in the `vars/` directory.
*   **Stages:**
    *   **Build Image:** Compiles the Docker image.
    *   **Scan Image:** Executes a Trivy security scan against the built image.
    *   **Push Image:** Authenticates and pushes the secure image to the AWS ECR repository.
    *   **Delete Image Locally:** Cleans up the Jenkins worker node storage.
    *   **Update Manifests:** Dynamically updates the Kubernetes Deployment YAML with the newly built image tag.
    *   **Push Manifests:** Commits the updated YAML file back to this GitHub repository.

### 6. Continuous Deployment (ArgoCD GitOps)
*   **Automation:** ArgoCD is configured within the cluster to monitor the repository's Kubernetes manifests.
*   **Sync:** Automatically detects changes pushed by Jenkins and synchronizes the EKS cluster state to match the repository, achieving true Continuous Deployment.

---

## 🚀 Setup Instructions

### Step 1: Provision Infrastructure
Navigate to the Terraform directory, initialize the S3 backend, and apply the modules to create the VPC, EKS cluster, ECR repository, and EC2 instance.
```bash
terraform init
terraform apply -auto-approve

### Step 2: Configure the Jenkins Server
Navigate to the Ansible directory and execute the configuration playbook using the AWS dynamic inventory.

```bash
ansible-playbook -i inventory/aws_ec2.yml playbook.yml

### Step 3: Initialize the CI Pipeline
Access the fully configured Jenkins UI. Create a new Pipeline project pointing to the `Jenkinsfile` in this repository to automate the build, test, and push cycles.

### Step 4: Deploy the GitOps Controller
Apply the ArgoCD Custom Resource manifest to your EKS cluster. ArgoCD will immediately pull the manifests from the `k8s/` directory and deploy the `ivolve` namespace, application replicas, Service, and Ingress.

```bash
kubectl apply -f argocd/application.yaml
