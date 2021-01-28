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
                    docker.withRegistry('docker.io', 'joepreludian-docker-creds') {
                        docker.build("joepreludian/python-poetry").push('latest')
                    }
                }
            }
        }
    }
    post {
        always {
            echo "Cleaning up docker image"
            sh "docker rmi python-poetry-build-${env.BUILD_NUMBER}"
        }
    }
}
