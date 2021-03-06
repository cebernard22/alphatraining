pipeline {
    agent { label 'build' }


    stages {

        stage('Increment version') {            
            when { branch "main" }
            steps {
                script {

                    echo 'Retrieving current app version from setup.py file ...'                    
                    def currentVersion = sh(script: 'python3 setup.py --version', returnStdout: true)
                    echo "incrementing app version from ${currentVersion}"                    
                    sh(script: "./pipelines/build.sh ${currentVersion} ", returnStdout: true)   



                }
            }
        }
        
        stage('BuildPython') {             
            steps {
                echo 'Building product: TODO, building python package and updating docker image...'  
                script {
                    echo "building python package...."
                    sh 'python3 setup.py clean --all'
                    sh 'python3 setup.py sdist bdist_wheel'                    
                }               
            }
        }


         



        stage('Test') {             
            steps {
                script {                
                    echo 'Installing package...'  
                    sh " pip install .[test] ."
                    echo 'Testing package...'                 
                    sh 'pytest --cov-report term --cov=alphamonitor tests'                    
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
                        sh("git config core.sshCommand 'ssh -i ${SSH_KEY_FOR_GITHUB} -o StrictHostKeyChecking=no'")
                        sh('git remote set-url origin git@github.com:cebernard22/alphatraining.git')
                        sh 'git add .'
                        sh 'git commit -m "jenkins ci: version bump"'                        
                        sh 'git push origin HEAD:main'
                    }
                }
            }
        }



        stage('DeployDocker') { 
            agent { label 'build' }
            when { branch "main" }
            steps {
                echo 'Building docker image ...'  
                script {
                    echo 'Retrieving new app version from setup.py file ...' 
                    def version = sh(script: 'python3 setup.py --version', returnStdout: true)                                    
                    version = version.replaceAll(/\s*$/, '')
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"                    
                    env.IMAGE_REF="registry.gitlab.com/ce.bernard.perso/alphatraining"
                    echo "building and pushing the docker image ${env.IMAGE_REF}:${env.IMAGE_NAME}..."
                    withCredentials([usernamePassword(credentialsId: 'gitlab_registry', passwordVariable: 'PASS', usernameVariable: 'USER')]) {                                                
                        sh "docker build -t ${IMAGE_REF}:${IMAGE_NAME} ."
                        sh "echo $PASS | docker login registry.gitlab.com -u $USER --password-stdin"
                        sh "docker push ${IMAGE_REF}:${IMAGE_NAME}" 
                    }
                }                
            }
        }           
    }
}