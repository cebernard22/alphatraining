pipeline {
    agent any 

    environment {
        ECR_REPO_URL = '664574038682.dkr.ecr.eu-west-3.amazonaws.com'
        IMAGE_REPO = "${ECR_REPO_URL}/java-maven-app"        
    }


    stages {

        stage('Increment version') {
            when { branch "main" }
            steps {
                script {

                    echo 'Retrieving current app version from setup.py file ...'                    
                    def currentVersion = sh(script: 'python3 setup.py --version', returnStdout: true)
                    echo "incrementing app version from ${currentVersion}"
                    //sh "python3 -v -m pip install bumpversion"
                    sh(script: "./pipelines/build.sh ${currentVersion} ", returnStdout: true)   
                    echo 'Retrieving new app version from setup.py file ...' 
                    def version = sh(script: 'python3 setup.py --version', returnStdout: true)                                    
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                    echo "############ ${env.IMAGE_NAME}"


                }
            }
        }

        stage('commit version update') {
            when { branch "main" }
            steps {
                script {
                    withCredentials(bindings: [sshUserPrivateKey(credentialsId: 'github_ssh_key', \
                                             keyFileVariable: 'SSH_KEY_FOR_GITHUB', \
                                             passphraseVariable: '', \
                                             usernameVariable: 'USER')]) {
                        sh("git config core.sshCommand 'ssh -i ${SSH_KEY_FOR_GITHUB}'")
                        sh('git remote set-url origin git@github.com:cebernard22/alphatraining.git')
                        sh 'git add .'
                        sh 'git commit -m "jenkins ci: version bump"'                        
                        sh 'git push origin HEAD:jenkinsfile'
                    }
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