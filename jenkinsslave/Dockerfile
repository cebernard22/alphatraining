    # retrieveing base image for jenkins agents
    FROM jenkins/inbound-agent:4.7-1-alpine


    USER root

    # Refresh package list
    RUN apk update &&  apk upgrade

    # including python items to build python library 
    RUN apk add python3 py3-pip
    RUN pip3 install --upgrade pip setuptools wheel
    RUN pip3 install bumpversion setupext-janitor

    # including docker items to build docker image and push it to docker hub   
    RUN apk add --no-cache docker-cli
    
    
    #Create docker group in the container
    RUN addgroup -g 1001 docker
    
    # add jenkins user to docker group
    RUN addgroup jenkins docker 
   
    
    

    USER jenkins



    #Test: docker run -v "//var/run/docker.sock:/var/run/docker.sock" -d --env-file ./jenkinsslave/env.list build-slave:0.2 -url http://5418f13bb944.ngrok.io <SECRET_ID> <JENKINS_NODE_REF>
    

