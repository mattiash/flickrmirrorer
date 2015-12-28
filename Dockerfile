FROM ubuntu:15.10
MAINTAINER mattias@holmlund.se
ENV FLICKRAPI_VERSION 2.1.2

RUN apt-get update && apt-get install -y python-setuptools python-requests
WORKDIR /tmp
ADD https://pypi.python.org/packages/source/f/flickrapi/flickrapi-$FLICKRAPI_VERSION.tar.gz /tmp/
RUN tar xzf flickrapi-$FLICKRAPI_VERSION.tar.gz && cd flickrapi-$FLICKRAPI_VERSION && python setup.py install

ADD ./flickrmirrorer /usr/lib/python2.7/dist-packages/flickrmirrorer.py
ADD ./flickrmirrorer.jenkins ./docker-run-flickrmirrorer /usr/local/bin/

RUN mkdir /data
VOLUME /data
CMD ["/usr/local/bin/docker-run-flickrmirrorer"]
