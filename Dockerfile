FROM anapsix/alpine-java:8
MAINTAINER Alexander Tolstikov <tolstikov@gmail.com>

WORKDIR /jenkins-cli
COPY jenkins-cli-wrapper.sh .

RUN chmod +x jenkins-cli-wrapper.sh

ENV JENKINS_URL ""
ENV PRIVATE_KEY "/ssh/id_rsa"
VOLUME /ssh

RUN apk add --update --no-cache \
  bash \
  ca-certificates \
  curl \
  openssh \
  openssl \
  openssl-dev \
  procps \
  tar \
  unzip \
  wget \
  && update-ca-certificates \
  &&  rm -rf /var/lib/apt/lists/*

# SSH config.
RUN mkdir -p /root/.ssh
ADD config/ssh /root/.ssh/config
RUN chmod 600 /root/.ssh/config

ENTRYPOINT ["./jenkins-cli-wrapper.sh"]
CMD ["help"]
