

<!-- TOC -->

- [1. Introduction](#1-introduction)
- [2. Git](#2-git)
- [3. Visual Studio Code](#3-visual-studio-code)
- [4. Kubernetes](#4-kubernetes)
  - [4.1. Ingress](#41-ingress)

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
https://www.youtube.com/watch?v=X48VuDVv0do

## 4.1. Ingress
Ingress inside WSL is a bit tricky. 
Following command is not working fine:

```
minikube addons enable ingress
```

Workaround is to use a cloud ingress controller like NGINX, as describred here: 
https://hellokube.dev/posts/configure-minikube-ingress-on-wsl2/

In case you are having issues to access the services from windows webbrowser, an additionnal workaround is to use a webbrowser installed in a WSL Linux instance. Xserver shall be installed for this purpose until Windows relase WSL update ( planned in 2021)
https://techcommunity.microsoft.com/t5/windows-dev-appconsult/running-wsl-gui-apps-on-windows-10/ba-p/1493242

Do not forget to keep opened a terminal instance where the following command is executed:
```
minikube tunnel
```