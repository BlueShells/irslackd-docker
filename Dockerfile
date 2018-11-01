FROM fedora:latest
MAINTAINER Dave Baker <dbaker@redhat.com>

# - perform in one RUN statement to minimize intermediate images
RUN yum -y install libtool-ltdl libnsl libstdc++ ncurses npm && \
    yum -y install wget hostname findutils telnet git npm && \
    yum -y install procps-ng net-tools && \
    yum -y update && \
    yum clean all && \
    rm -rf /var/cache/yum

# Create a non-root account to use
RUN useradd user

# Default port
EXPOSE 6697:6697

# Create empty dir for volume mount
RUN mkdir /config && chown -R user /config
VOLUME /config

# Copy installer plus our bootstrap code into user's home
COPY bootstrap.sh /home/user

# From here, we run as non-root.  Actual bootstrap config
# takes place inside the data volume after the first run so
# as to be preserved between restarts.
USER    user
WORKDIR /config
CMD     /home/user/bootstrap.sh


