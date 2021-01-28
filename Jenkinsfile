pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh "docker build --rm --compress -t python-poetry-build-${env.BUILD_NUMBER} ."
                sh "docker images | grep \"python-poetry-build-\""
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
	                    sh "docker login --username \"${DOCKER_USER}\" --password \"${DOCKER_PW}\""
	                    sh 'docker tag python-poetry-build-${env.BUILD_NUMBER} joepreludian/python-poetry:latest'
	                    sh 'docker push joepreludian/python-poetry:latest'
                    }
                }
            }
        }
    }
    post {
        always {
            echo "Cleaning up docker image"
            sh "docker rmi python-poetry-build-${env.BUILD_NUMBER} || true"
            sh 'docker rmi joepreludian/python-poetry:latest || true'
            script {
                currentBuild.rawBuild.project.description = '<h3>Python Poetry</h3><p>Temp</p>'
            }
        }
    }
}
