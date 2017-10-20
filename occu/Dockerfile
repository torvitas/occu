ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV TZ Europe/Berlin

RUN apt-get update \
    && apt-get install -y --force-yes openjdk-8-jre-headless \
        msmtp \
        tcl \
        tcllib \
        libusb-1.0-0-dev \
        supervisor \
    && rm -rf /var/lib/apt/lists/* \

COPY firmware/ /firmware/
RUN mkdir -p /opt/hm
COPY arm-gnueabihf/packages/lighttpd/ /opt/hm/
COPY arm-gnueabihf/packages-eQ-3/HS485D/ /opt/hm/
COPY arm-gnueabihf/packages-eQ-3/RFD/ /opt/hm/
COPY arm-gnueabihf/packages-eQ-3/WebUI/ /opt/hm/
COPY arm-gnueabihf/packages-eQ-3/LinuxBasis/ /opt/hm/
COPY WebUI/ /
COPY HMserver/ /
COPY supervisor/ /etc/supervisor/

VOLUME ["/usr/local"]

EXPOSE 80 90 443 2000 2001 2002 8001 8002 8181 4430 4431 4432 44381

CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf"]
