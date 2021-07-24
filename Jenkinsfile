pipeline {
    agent any 


    stages {


        
        stage('Build') { 
            steps {
                echo 'Building product: TODO, building python package and updating docker image...'  
                script {
                    echo "building python package...."
                    sh 'python3 setup.py clean --all'
                    sh 'python3 setup.py sdist bdist_wheel'
                    echo "building the docker image ${IMAGE_NAME}..."
                    withCredentials([usernamePassword(credentialsId: 'gitlab_registry', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "docker build -t ce.bernard.perso/alphatraining:${IMAGE_NAME} ."
                        sh "echo $PASS | docker login registry.gitlab.com -u $USER --password-stdin"
                        //sh "docker push registry.gitlab.com/ce.bernard.perso/alphatraining:${IMAGE_NAME}"

                    }
                }

                
            }
        }
        stage('Test') { 
            steps {
                echo 'Testing product: TODO once build stage is completed...'  
            }
        }



        stage('Increment version') {
            agent { label 'build' }
            when { branch "jenkinsfile" }
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
                        sh 'git push origin HEAD:main'
                    }
                }
            }
        }




        stage('Deploy') { 
            steps {
                echo 'Deploying product to docker repository: TODO once other stages are completed...' 
            }
        }
    }
}