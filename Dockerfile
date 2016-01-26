FROM centos:7.2.1511
MAINTAINER wlu wlu@linkernetworks.com

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

RUN yum install -y php-common php-cli php-gb php

# install ganglia server
RUN yum install -y rrdtool rrdtool-devel ganglia-web ganglia-gmetad \
    ganglia-gmond ganglia-gmond-python httpd apr-devel zlib-devel \
    libconfuse-devel expat-devel pcre-devel

# install ganglia client
RUN yum install -y ganglia-gmond

RUN mkdir -p /var/lib/ganglia/rrds && \
    chown nobody:nobody /var/lib/ganglia/rrds && \
    chmod a+w /var/lib/ganglia/rrds

ADD supervisord.conf /etc/supervisord.conf
RUN yum install -y python-setuptools && \
    easy_install supervisor && \
    yum clean all

RUN yum clean all && yum swap fakesystemd systemd

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
