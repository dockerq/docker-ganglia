FROM centos:6
MAINTAINER wlu wlu@linkernetworks.com

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm

RUN yum install -y php-common php-cli php-gb php

# install ganglia server
RUN yum install -y rrdtool rrdtool-devel ganglia-web ganglia-gmetad \
    ganglia-gmond ganglia-gmond-python httpd apr-devel zlib-devel \
    libconfuse-devel expat-devel pcre-devel

# install ganglia client
RUN yum install -y ganglia-gmond

RUN mkdir -p /var/lib/ganglia/rrds && \
    chown nobody:nobody /var/lib/ganglia && \
    chmod 777 /var/lib/ganglia

ADD supervisord.conf /etc/supervisord.conf
RUN yum install -y python-setuptools && \
    easy_install supervisor && \
    yum clean all

RUN yum remove -y iptables && yum install -y vim  

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
