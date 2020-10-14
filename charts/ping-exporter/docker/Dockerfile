FROM python:3.6-alpine3.8
COPY . /app
WORKDIR /app

RUN apk update && apk add --no-cache curl jq fping
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod u+x kubectl && mv kubectl /bin/kubectl

COPY ./start.sh .
RUN chmod +x /app/start.sh

RUN pip3 install --upgrade pip && pip3 install -r requirements.txt
ENTRYPOINT ["sh", "/app/start.sh"]