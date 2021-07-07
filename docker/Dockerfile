FROM python:3

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

 
COPY ./app/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY ./app .

CMD [ "python","-u", "./hello.py" ]