
<!-- TOC -->

- [1. Introduction](#1-introduction)
- [2. Git](#2-git)
- [3. Visual Studio Code](#3-visual-studio-code)
- [4. Kubernetes](#4-kubernetes)
  - [4.1. Ingress](#41-ingress)
- [5. Docker](#5-docker)
  - [5.1. Docker Registery](#51-docker-registery)
- [6. Python](#6-python)
- [7. Jenkins](#7-jenkins)
  - [7.1. Github integration](#71-github-integration)
  - [7.2. Jenkins Pipeline](#72-jenkins-pipeline)
  - [7.3. Jenkins Slave](#73-jenkins-slave)
  - [7.4. Jenkins Dynamic push into github](#74-jenkins-dynamic-push-into-github)

<!-- /TOC -->

# 1. Introduction

AlphaTraining is a new repository to pratice on DevOps assets.
The training path to start this journey will be the following one:

- Git, JIRA

- Visual Studio

- Kubernetes

- Docker

- Terraform

- Helm

- Ansible

- Packer

- S3

- Artifactory

Some tips will also be shared on Python & TravisCI, since used from functionnal point of view
  
# 2. Git

  Simple but nice quickstart to learn fast PR, branches, and other useful tips
  <https://guides.github.com/activities/hello-world/>
  Use VisualStudioCode plugins to interact easily with github repository

  JIRA<->Github: Following project is in use to monitor progress and run some quick prototypes:
  <https://alphatraining.atlassian.net/browse/BAC>
  
# 3. Visual Studio Code

![alt text][logo]

[logo]: ./visualstudio/vstudio48.png "VisualStudioCode"

Nice HowTo here to improve the way we write down md files in VSCode: <https://thisdavej.com/build-an-amazing-markdown-editor-using-visual-studio-code-and-pandoc/>

Inluding a reference with a cheatsheet to easily retrieve legacy md syntax:
<https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet>

# 4. Kubernetes

The link below is a great support to learn K8s from the basics:
<https://www.youtube.com/watch?v=X48VuDVv0do>

## 4.1. Ingress

Ingress inside WSL is a bit tricky.
Following command is not working fine:

```kubernetes
minikube addons enable ingress
```

Workaround is to use a cloud ingress controller like NGINX, as describred here:
<https://hellokube.dev/posts/configure-minikube-ingress-on-wsl2/>

**Do not forget to**:

- Keep opened a terminal instance where the following command is executed:

```kubernetes
minikube tunnel
```

- Disable your firewall, or finetune the rules so the access to your services is allowed

- Configure your hosts file in C:\Windows\System32\drivers\etc  so the service name is known

```hostfile
127.0.0.1 alphatrainingz.com
```

In case you are having issues to access the services from windows webbrowser, an additionnal workaround is to use a webbrowser installed in a WSL Linux instance. Xserver shall be installed for this purpose until Windows relase WSL update ( planned in 2021)
<https://techcommunity.microsoft.com/t5/windows-dev-appconsult/running-wsl-gui-apps-on-windows-10/ba-p/1493242>

# 5. Docker

The link below is a great support to learn Docker in an efficient way:
<<https://www.youtube.com/watch?v=3c-iBn73dD>
Do not forget to use docker plugin from Visul Studio Code. CLI commands are nice to learn, but efficiency is improved using this plugin.

## 5.1. Docker Registery

For public docker registry, dockerhub is the way to go.

For private docker registry, free plan from gitlab is a good way to start with: 10GB available, for free :-)
<<https://about.gitlab.com/blog/2016/05/23/gitlab-container-registry>

Other alternatives can be found here:
<https://www.slant.co/topics/2436/~best-docker-image-private-registries>

# 6. Python

For training purpose, we will create a python module called alphamonitor interacting with JIRA project.
Sources codes are located in alphamonitor directory, and testfiles triggered by pytest will be located in test directory.
From VSCode, we take the benefit of "Testing" tab and "Run and Debug" tab.
Short reminder on pytest:

- test files names using test_ as prefix,
- tests named using test_ as prefix in the function name,
- assert used to trigger errors

-
More informations on pytest: <https://docs.pytest.org/en/latest/explanation/goodpractices.html#test-discovery>
Using venv to test the local copy of the code, do not forget to execute the following command:
  
```bash
  pip install --editable .
```

Side note: in case pip install is (super) slow, check that DISPLAY variable is unset, and manually unset it if not done

```bash
  unset DISPLAY
```

Check here for more details : <https://github.com/pypa/pip/issues/8485>

Alphamonitor will be packaged, and TravisCI will be used to trigger the CI/CD system. TravisCI is used here as a nice candidate in case we don't have any jenkins server in place.

- Nice link to get more insights on python package : <https://packaging.python.org/tutorials/packaging-projects/>
- Another useful link to quickstart using TravisCI for python : <https://blog.travis-ci.com/2019-08-07-extensive-python-testing-on-travis-ci>
- Coverage capacity using TravisCI & codecov: <https://dev.to/j0nimost/using-codecov-with-travis-ci-pytest-cov-1dfj>

- Encrypted key when it comes to publish distribution: <https://docs.travis-ci.com/user/deployment/pypi/>  . Using encrypted password did not work properly, I had to tweak a little bit the system using pypi-xxx passsword in the TravisCI environment variable. Probably related to a missleading copy/paste value?
- NiceHowto to update travis.yml file for deployment stage: <https://mikkokotila.medium.com/deploying-python-packages-to-pypi-with-travis-works-9a6597781556>
- Check .travis.yml consistency:

```bash
  travis lint
```

To manage version properly, a good practice is to use bum2version as described here: <https://pypi.org/project/bump2version/>
It will be triggered from Jenkins pipeline in the build stage

# 7. Jenkins

Following this link to install Jenkins on minikube: <https://www.jenkins.io/doc/book/installing/kubernetes/>

Another way is to install the jenkins master in a container, skipping Kubernetes layer: <https://www.youtube.com/watch?v=pMO26j2OUME>

## 7.1. Github integration

Once Jenkins is installed, webhook shall be configured so each commit/PR triggers a pipeline

- Create a multibranch job and the relevant jenkinsfile: Nana's short videos will help you for this :-) : <https://www.youtube.com/watch?v=tuxO7ZXplRE>

- Prepare Github webhook : <https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/Fix-No-Valid-Crumb-Error-Jenkins-GitHub-WebHook-Included>
- Ngrok is the easiest way to ensure Github can interact properly with you self hosted jenkins: <https://dashboard.ngrok.com/get-started/setup>

## 7.2. Jenkins Pipeline

In case we need to execute python scripts on jenkins master ( to retrieve version id for instance) , python and dist utils needs to be installed first inside the docker image:

```bash
  docker ps
  docker exec -u 0 -it xxxx bash 
```

-u 0 to be root user so we can install some modules in the container

Then inside the docker:

```bash
  apt install python3
  apt-get install python3-setuptools
  apt install python3-pip
```

To be noted running a job in the master is not a good practice. Shall be done only for quick ( and dirty) prototyping where we have not defined any node in our jenkins master

## 7.3. Jenkins Slave

In order to avoid running pipelines on master, we can connect some docker using jlnp connections:

```bash
   docker run -d --env-file ./jenkinsslave/env.list jenkins/inbound-agent -url <NGROK_ADRESS> <SECRET> docker_node

```

evn.list is used so we can get the benefit of websocket, and avoid having some connection refused for TCP port 50000

More informations here: <https://plugins.jenkins.io/digitalocean-plugin/>  , <https://hub.docker.com/r/jenkins/inbound-agent>
Note: "Launch agent by connecting it to the master"  is same as "launch agent via java web start"

## 7.4. Jenkins Dynamic push into github

In order to properly push some commits to github when the pipelines updates some files ( i.e. version files), we shall proceed as follow:

- Generate a SSH key for jenkins master: log into jenkins docker, the run the following commands:
  
```bash
  ssh-keygen -t rsa
  cat ~/.ssh/id_rsa.pub
```

- Define this public key in the "Deploy keys" section of the github repository
- Define the private key SSH_KEY_FOR_GITHUB in the "Global Credentials" section of jenkins master
- Run the following commands from the jenkinsfile
  
  ```bash
        stage('commit version update') {
            steps {
                script {
                    withCredentials(bindings: [sshUserPrivateKey(credentialsId: 'github_ssh_key', \
                                             keyFileVariable: 'SSH_KEY_FOR_GITHUB', \
                                             passphraseVariable: '', \
                                             usernameVariable: 'USER')]) {

                        sh "git status"
                        sh "git branch"
                        sh("git config core.sshCommand 'ssh -i ${SSH_KEY_FOR_GITHUB}'")
                        sh('git remote set-url origin git@github.com:cebernard22/alphatraining.git')
                        sh 'git add .'
                        sh 'git commit -m "jenkins ci: version bump"'                        
                        sh 'git push origin HEAD:jenkinsfile'
                    }
                }
            }
        }

```
  
To be noted once this works properly, whe shall use the ignore  commiter strategy plugin ( https://plugins.jenkins.io/ignore-committer-strategy/) to avoid an endless loop where setup.py update trigger another jenkins pipeline ;-)
