pipeline {
    agent any 

    stages {
        stage('Build') { 
            steps {
                echo 'Building product: TODO...'  
            }
        }
        stage('Test') { 
            steps {
                echo 'Testing product: TODO once build stage is completed...'  
            }
        }
        stage('Deploy') { 
            when {
                env.BRANCH_NAME == 'jenkinsfile'

            }
            steps {
                echo 'Deploying product to docker repository: TODO once other stages are completed...' 
                echo 'DOCKER_LOGIN: ' + env.DOCKER_LOGIN
                withCredentials(usernamePassword(credentials('DOCKER_LOGIN'),usernameVariable:DOCKER_LOGIN,passwordVariable:DOCKER_PWD)) {
                    sh "docker login to be called here"
                    echo "DOCKER_LOGIN:$DOCKER_LOGIN"
                    echo "DOCKER_PWD:$DOCKER_PWD"
                }
            }
        }
    }
}