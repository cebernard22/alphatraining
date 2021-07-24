FROM python:3



RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

 
COPY ./docker/app/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY ./docker/app .

CMD [ "python","-u", "./hello.py" ]

