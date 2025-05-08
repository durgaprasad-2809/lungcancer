mkdir docker
mv Dockerfile docker/
git add docker/Dockerfile
git commit -m "Moved Dockerfile to docker/ directory"
git push
FROM python:3.9-slim

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt

CMD ["python3", "main.py"]
