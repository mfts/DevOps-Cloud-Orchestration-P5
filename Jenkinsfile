pipeline {
	agent any
	environment {
		registry = "mfts/jitsi-meet-client"
   }
	stages {
		stage('Checkout Git') {
			steps {
				checkout scm
			}
		}
		stage('Lint Dockerfile') {
			steps {
				sh 'hadolint Dockerfile'
			}
		}
		stage('Build & publish Docker image') {
			environment {
        registryCredential = 'dockerhub'
      }
			steps{
				script {
					def app_image = docker.build registry + ":$BUILD_NUMBER"
					docker.withRegistry('', registryCredential ) {
						app_image.push()
						app_image.push('latest')
					}
				}
			}        
		}
		stage('Deploy to AWS') {
			steps {
				withAWS(region:'eu-central-1', credentials:'aws-jenkins') {
					sh "aws eks --region eu-central-1 update-kubeconfig --name UdacityCapstoneMFTS-EKS"
					sh "kubectl apply -f k8s/aws-auth-cm.yaml"
          sh "kubectl apply -f k8s/app-deployment.yml"
					sh "kubectl set image deployments/jitsi-meet jitsi-meet=${registry}:latest"
					// sh "./update.sh eks-nodes-mfts k8s/nodes.yml k8s/nodes-params.json"
          sh "kubectl get nodes"
					sh "kubectl get pods"
          sh "kubectl apply -f k8s/service.yml"
				}
			}
		}
	}
}