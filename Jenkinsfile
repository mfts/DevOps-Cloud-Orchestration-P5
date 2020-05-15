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
	}
}