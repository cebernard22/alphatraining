
<!-- TOC -->

- [1. Introduction](#1-introduction)
- [2. Git](#2-git)
- [3. Visual Studio Code](#3-visual-studio-code)
- [4. Kubernetes](#4-kubernetes)
  - [4.1. Ingress](#41-ingress)
- [5. Docker](#5-docker)
  - [5.1. Docker Registery](#51-docker-registery)

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
