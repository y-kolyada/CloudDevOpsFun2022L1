FROM alpine:latest

RUN apk add --update python3 py3-pip 

RUN apk add curl

COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

COPY app.py /usr/src/app/
COPY templates/index.html /usr/src/app/templates/
COPY static/* /usr/src/app/static/

EXPOSE 5000

CMD ["python", "/usr/src/app/app.py"]
