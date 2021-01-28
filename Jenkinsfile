pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh "docker build --compress -t python-poetry-build-${env.BUILD_NUMBER}:latest ."
                sh "docker images | grep \"python-poetry-build-\""
            }
        }
        stage('Inspect') {
            agent {
                docker {
                    image "python-poetry-build-${env.BUILD_NUMBER}:latest"
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
                    image "python-poetry-build-${env.BUILD_NUMBER}:latest"
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
	                    sh 'docker login --username "$DOCKER_USER" --password "$DOCKER_PW"'

	                    figlet 'Tag'
	                    sh 'docker tag python-poetry-build-${env.BUILD_NUMBER}:latest joepreludian/python-poetry:latest'

	                    figlet 'Push'
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
            sh 'docker logout'
            /*
            script {
                currentBuild.rawBuild.project.description = '<h3>Python Poetry</h3><p>Temp</p>'
            }
            */
        }
    }
}
