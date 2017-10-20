ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV TZ Europe/Berlin

RUN echo "deb http://archive.raspberrypi.org/debian/ stretch main" >> /etc/apt/sources.list.d/raspberrypi.list

RUN apt-get update \
    && apt-get install -y --allow-unauthenticated oracle-java8-jdk \
        msmtp \
        tcl \
        tcllib \
        libusb-1.0-0-dev \
        libssl1.0-dev \
        supervisor \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s jdk-8-oracle-arm32-vfp-hflt /usr/lib/jvm/java-8-oracle

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

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
    ln -s /usr/local/etc/config /etc/config && \
    ln -s /usr/lib/arm-linux-gnueabihf/libcrypto.so.1.0.2 /lib/arm-linux-gnueabihf/libcrypto.so.1.0.0 && \
    ln -s /usr/lib/arm-linux-gnueabihf/libssl.so.1.0.2 /lib/arm-linux-gnueabihf/libssl.so.1.0.0
COPY supervisor/ /etc/supervisor/
COPY HMserver/etc/config_templates/log4j.xml /etc/config/

VOLUME ["/usr/local"]

EXPOSE 80 90 443 2000 2001 2002 8001 8002 8181 4430 4431 4432 44381

CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf"]
