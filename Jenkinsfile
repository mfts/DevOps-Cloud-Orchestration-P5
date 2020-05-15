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
	}
}