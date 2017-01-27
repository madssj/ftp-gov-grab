FROM python:2-slim

WORKDIR /srv
ADD . /srv/ftp-gov-grab/

RUN apt-get update \
	&& apt-get install -y rsync wget \
	&& pip install seesaw warc requests

RUN wget https://launchpad.net/wpull/trunk/v2.0.1/+download/wpull-2.0.1-linux-x86_64-3.4.3-20161230193838.zip \
	&& python -c "import zipfile; f=zipfile.ZipFile('wpull-2.0.1-linux-x86_64-3.4.3-20161230193838.zip'); f.extractall('./')" \
	&& chmod +x ./wpull \
	&& mv ./wpull /usr/bin \
	&& rm -f wpull-2.0.1-linux-x86_64-3.4.3-20161230193838.zip

ENTRYPOINT ["run-pipeline", "/srv/ftp-gov-grab/pipeline.py"]

EXPOSE 8001
