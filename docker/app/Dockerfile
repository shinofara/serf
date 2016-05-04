FROM ubuntu:16.04


RUN apt-get update -y
RUN apt-get install -y wget unzip

# Install Serf
RUN wget -nv https://releases.hashicorp.com/serf/0.7.0/serf_0.7.0_linux_amd64.zip && \
    echo "b239fdcd1c15fd926ff0cd10bc32a31330d1c74aba9e4d49ff83d5707ef1ba4b  serf_0.7.0_linux_amd64.zip" | sha256sum -c - && \
    unzip serf_0.7.0_linux_amd64.zip -d /usr/bin && \
    rm serf_0.7.0_linux_amd64.zip

# Install supervisor
#   https://docs.docker.com/engine/admin/using_supervisord/
RUN apt-get install -y openssh-server apache2 supervisor
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


WORKDIR /working
COPY cgi-bin /working/cgi-bin

EXPOSE 22 7946 9000
CMD ["/usr/bin/supervisord"]
