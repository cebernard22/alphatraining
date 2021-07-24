FROM python:3

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

 
COPY ./app/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY ./app .

CMD [ "python","-u", "./hello.py" ]

RUN mkdir -p /usr/app
COPY ./dist/alphamonitor_cebernard22_*.tar.gz /usr/app/
WORKDIR /usr/app

CMD java -jar java-maven-app-*.jar
