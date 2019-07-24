FROM openjdk:8-alpine
COPY a.py /app.py
COPY kmeans.py /kmeans.py
COPY req.txt /requirements.txt
COPY dependencies.zip /dependencies.zip



RUN apk add --update openssl wget bash 

RUN apk update && \
    echo "**** install Python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi
    
