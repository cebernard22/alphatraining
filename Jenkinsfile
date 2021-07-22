pipeline {
    agent any 

    environment {
        ECR_REPO_URL = '664574038682.dkr.ecr.eu-west-3.amazonaws.com'
        IMAGE_REPO = "${ECR_REPO_URL}/java-maven-app"
        IMAGE_NAME = ""
    }


    stages {

        stage('Increment version') {
            steps {
                script {
                    echo 'incrementing app version...: TODO'
                    echo 'Retrieving app version from setup.py file...'
                    def matcher = readFile('setup.py') =~ 'version=(.+)'
                    def version = matcher[0][1]
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                    echo "############ ${IMAGE_REPO}"
                }
            }
        }

        
        stage('Build') { 
            steps {
                echo 'Building product: TODO, updating version defined in setup.py...'  
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
                    sh "docker login to be called here using groovy script"
                    echo "DOCKER_LOGIN:$DOCKER_LOGIN"
                    echo "DOCKER_PWD:$DOCKER_PWD"
                }
            }
        }
    }
}