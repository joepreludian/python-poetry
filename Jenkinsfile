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
 		stage('Testing') {
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
        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                echo 'Deploy image'
                script {
                    withCredentials([usernamePassword(credentialsId: 'joepreludian-docker-creds',
                        usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PW')]) {
	                    sh "echo \"${DOCKER_PW}\" | docker login --username \"${DOCKER_USER}\" --password-stdin"
	                    sh "docker tag python-poetry-build-${env.BUILD_NUMBER}:latest joepreludian/python-poetry:latest"
                    }
                }
            }
        }
    }
    post {
        always {
            echo "Cleaning up docker image"
            sh "docker rmi python-poetry-build-${env.BUILD_NUMBER} || true"
            sh 'docker rmi joepreludian/python-poetry:latest'
        }
    }
}
