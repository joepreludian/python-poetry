pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh "docker build -t python-poetry-build-${env.BUILD_NUMBER} ."
            }
        }
        stage('Inspect') {
            agent {
                docker {
                    image "python-poetry-build-${env.BUILD_NUMBER}"
                }
            }
            steps {
                sh 'python --version'
                sh 'pip --version'
                sh 'poetry --version'
     		}
 		}
    }
}