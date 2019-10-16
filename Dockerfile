FROM python:3-stretch

LABEL name="ecr-login"
LABEL version="1.0.0"
LABEL repository="http://github.com/thalesvon/ecr-login"
LABEL homepage="http://github.com/thalesvon/ecr-login"

LABEL maintainer="Thales Sperling <thalesvon@gmail.com>"
LABEL com.github.actions.name="GitHub Action for AWS ECR Login"
LABEL com.github.actions.description="ECR Login for Github Actions v2"
LABEL com.github.actions.icon="box"
LABEL com.github.actions.color="yellow"

ENV DOCKERVERSION=18.06.1-ce
RUN apt-get update && \
  apt-get install -y --no-install-recommends curl groff jq && \
  apt-get -y clean && apt-get -y autoclean && apt-get -y autoremove && \
  curl -fsSLO https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64 && \
  mv heptio-authenticator-aws_0.3.0_linux_amd64 /usr/local/bin/aws-iam-authenticator && \
  chmod +x /usr/local/bin/aws-iam-authenticator && \
  curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz && \
  tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker && \
  rm docker-${DOCKERVERSION}.tgz && \
  rm -rf /var/lib/apt/lists/* && \
  pip install --upgrade pip && \
  pip install setuptools awscli

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]