FROM dorowu/ubuntu-desktop-lxde-vnc:latest
LABEL maintainer="bjzquan@cn.ibm.com"

ENV DISPLAY ":1"
ENV VNC_PASSWORD "Passw9rd!"
ENV HTTP_PASSWORD "Passw9rd!"

COPY robot-demo-test/ /root/robot-demo-test/
COPY testng-demo-test/ /root/testng-demo-test/

COPY chromedriver geckodriver /usr/local/bin/
COPY authorized_keys environment /root/.ssh/
COPY apache-maven-3.5.4/ /opt/maven/

RUN chmod 755 /usr/local/bin/chromedriver \
  && chmod 755 /usr/local/bin/geckodriver \
  && chmod 600 /root/.ssh/authorized_keys \
  && ln -s /opt/maven/bin/mvn /usr/local/bin/ \
  && apt-get update \
  && apt-get install -y openssh-server python-pip openjdk-8-jdk \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && mkdir -p /var/run/sshd \
  && sed -i 's/#PermitUserEnvironment no/PermitUserEnvironment yes/' /etc/ssh/sshd_config \
  && pip install robotframework robotframework-selenium2library

EXPOSE 22 80 5900
