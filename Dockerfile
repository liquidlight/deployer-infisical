ARG DEPLOYER_VERSION=v7
FROM deployphp/deployer:${DEPLOYER_VERSION}

RUN apk add --no-cache bash curl \
	&& curl -1sLf 'https://artifacts-cli.infisical.com/setup.apk.sh' | bash \
	&& apk add --no-cache infisical \
	&& infisical --version

ENTRYPOINT [""]
