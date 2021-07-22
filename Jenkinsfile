pipeline {
    agent any 

    environment {
        ECR_REPO_URL = '664574038682.dkr.ecr.eu-west-3.amazonaws.com'
        IMAGE_REPO = "${ECR_REPO_URL}/java-maven-app"        
    }


    stages {

        stage('Increment version') {
            steps {
                script {

                    echo 'Retrieving current app version from setup.py file ...'                    
                    def currentVersion = sh(script: 'python3 setup.py --version', returnStdout: true)
                    echo "incrementing app version from {$currentVersion}"
                    sh "python3 -v -m pip install bumpversion"
                    sh "./pipelines/build.sh {$currentVersion} "
                    echo 'Retrieving new app version from setup.py file ...' 
                    def version = sh(script: 'python3 setup.py --version', returnStdout: true)                                    
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                    echo "############ ${env.IMAGE_NAME}"


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
            steps {
                echo 'Deploying product to docker repository: TODO once other stages are completed...' 
            }
        }
    }
}