FROM ubuntu:trusty

# Prevent dpkg error
ENV TERM=xterm-256color

#Set mirrors to FI
RUN sed -i "s/http:\/\/archive./http:\/\/fi.archive./g" /etc/apt/sources.list


RUN apt-get update && \
  apt-get install -y \
  -o APT::Install-Recommend=false -o APT::Install-Suggests=false \
  python python-virtualenv libpython2.7 python-mysqldb


RUN virtualenv /appenv && \
  . /appenv/bin/activate && \
  pip install pip --upgrade


# Add entrypoint script
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
