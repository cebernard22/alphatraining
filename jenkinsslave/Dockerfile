    # retrieveing base image for jenkins agents
    FROM jenkins/inbound-agent:4.7-1-alpine


    USER root

    # Refresh package list
    RUN apk update &&  apk update

    # including python items to build python library 
    RUN apk add python3 py3-pip
    RUN pip3 install --upgrade pip setuptools wheel
    RUN pip3 install bumpversion setupext-janitor
    
    
    

    USER jenkins

