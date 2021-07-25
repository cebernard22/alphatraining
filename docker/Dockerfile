FROM python:3

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app




#Creating a new user "jenkins" and adding this user to the docker group ( 1001 is the docker group id from the host)
#docker.host shall be mapped during run, using -v command : -v "//var/run/docker.sock:/var/run/docker.sock"










# Create jenkins user
RUN useradd -s /bin/bash -d /usr/app/src jenkins



#Create docker group in the container
#RUN addgroup -g 1001 docker
RUN addgroup docker



# add jenkins user to docker group
RUN usermod -aG docker jenkins

#Testing Docker CLI commands from docker container
RUN apt update
RUN apt install docker.io -y
 

#Install the python3.6 runtime
COPY ./app/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY ./app .



USER jenkins

CMD [ "python","-u", "./hello.py" ]



#Test: docker run --rm -v "//var/run/docker.sock:/var/run/docker.sock" testdocker:0.1 /bin/sh -c "ls -l /var/run/docker.sock;docker ps"