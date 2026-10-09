# Deployer + Infisical

[Deployer](https://deployer.org/) Docker images (`deployphp/deployer`) with the [Infisical CLI](https://infisical.com/docs/cli/overview) pre-installed, so deploy jobs don't have to install it on every run.

## Tags

| Tag | Base image |
| --- | --- |
| `v7` | `deployphp/deployer:v7` |
| `v8` | `deployphp/deployer:v8` |
| `v7-<sha>` / `v8-<sha>` | Same as above, pinned to the commit of this repo that built it |

Images are published to the GitHub Container Registry for `linux/amd64` and `linux/arm64`. GitHub Actions rebuilds them on every push to `main` and weekly, so they pick up new Deployer releases and Infisical CLI versions.

See [container images](https://github.com/liquidlight/deployer-infisical/pkgs/container/deployer-infisical) for the details.

## Usage

```yaml
.deploy:deployer:
  image:
    name: ghcr.io/liquidlight/deployer-infisical:v7
  before_script:
    # ...
    - |
      if [ -f .infisical.json ] && [ -n "${INFISICAL_IDENTITY_ID}" ]; then
        INFISICAL_TOKEN=$(infisical login --method=oidc-auth --machine-identity-id="${INFISICAL_IDENTITY_ID}" --jwt="${GITLAB_OIDC_TOKEN}" --domain=${INFISICAL_HOST} --silent --plain)
        export INFISICAL_TOKEN
      fi
```

The entrypoint is already cleared, so `entrypoint: [""]` is no longer needed.

## Building locally

```bash
docker build -t deployer-infisical:v7 .
docker build --build-arg DEPLOYER_VERSION=v8 -t deployer-infisical:v8 .
```
