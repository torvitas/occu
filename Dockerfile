ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV TZ Europe/Berlin

RUN echo "deb http://archive.raspberrypi.org/debian/ jessie main" >> /etc/apt/sources.list.d/raspberrypi.list \
    && apt-get update \
    && apt-get install -y oracle-java8-jdk \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s jdk-8-oracle-arm32-vfp-hflt /usr/lib/jvm/java-8-oracle

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN apt-get update && apt-get install -y \
        msmtp \
        tcl \
        tcllib \
        libusb-1.0-0-dev \
        supervisor \
        --no-install-recommends && \
        rm -rf /var/lib/apt/lists/*
COPY HMserver /
COPY firmware/ /firmware/
COPY arm-gnueabihf/packages/lighttpd/ /
COPY arm-gnueabihf/packages-eQ-3/HS485D/ /
COPY arm-gnueabihf/packages-eQ-3/RFD/ /
COPY arm-gnueabihf/packages-eQ-3/WebUI/ /
COPY arm-gnueabihf/packages-eQ-3/LinuxBasis/ /
COPY WebUI/ /
COPY HMserver/ /
RUN ln -s / /opt/hm && \
    rm -rf /usr/local/* && \
    mkdir -p /usr/local/etc && \
    mv /etc/config /usr/local/etc/ && \
    ln -s /usr/local/etc/config /etc/config
COPY supervisor/ /etc/supervisor/

VOLUME ["/usr/local"]

EXPOSE 80 90 443 2000 2001 2002 8001 8002 8181 4430 4431 4432 44381

CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf"]
