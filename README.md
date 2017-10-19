# GO CD Test

GoCD test server for evaluation of GoCD features.

## Create Server

Creates GoCD server using the GoCD docker [server](https://github.com/gocd/docker-gocd-server) and [agent](https://github.com/gocd/docker-gocd-agent).

Allows for plugins to be uploaded to the container from the folder `./stack/containers/server/plugins/.gitignore`. The plugins in this folder can be downloaded using the shell script `./bin/gocd/get-plugins.sh` where the bash array contains strings of `repo:asset`, example:

```
PLUGINS=(
  "ashwanthkumar/gocd-slack-build-notifier:v1.4.0-RC10/gocd-slack-notifier-1.4.0-RC10.jar"
  "ashwanthkumar/gocd-build-github-pull-requests:v1.3.4/github-pr-poller-1.3.4.jar"
  "gocd-contrib/gocd-oauth-login:v2.4/github-oauth-login-2.4.jar"
  "gocd-contrib/gocd-build-status-notifier:1.3/github-pr-status-1.3.jar"
)
```

Bootstrap the project and create the Docker container using the `install` script:

```
sh ./bin/local/install.sh
```

You can rebuild the containers and start them using standard `docker-compose` commands after this.

## Pipelines

An example pipeline has been placed in `./ci/pipelines.yml` you can add as many pipelines as you want by creating more .yml files in this folder. If you do not want to use a folder called `ci` on your project see the configuration for the pipelines path in the config for the `yaml.config.plugin` plugin `./stack/containers/server/plugin-config/yaml.config.plugin.sh` under `file_pattern`.

## Authentication

Authentication is handled by the standard HTPASSWD based user login defined in the `.env.secure` file, and the Github Oauth plugin which is configured via the plugins [readme](https://github.com/gocd-contrib/gocd-oauth-login#configuration) and secrets stored in the `.env.secure` file.

## Secure environment file

To setup this repo please create a file `.env.secure` with these fields entered:

```
GOCD_USER=admin
GOCD_PASSWORD=admin
GOCD_PASSWORD_ENCRYPTED=$2a$05$1ANpmjHXcDqLJ5HCcYPBceb18Q1asejks2c.JzQ5Oe7sjyLansXGa
GITHUB_CLIENT_ID=<CLIENT ID>
GITHUB_CLIENT_SECRET_KEY=<SECRET KEY>
GITHUB_OAUTH_REDIRECT_URL=<PUBLIC REDIRECT URL>
```

Where `GOCD_PASSWORD_ENCRYPTED` is a hashed version of `GOCD_PASSWORD`. `GOCD_PASSWORD` is used to upload config settings, and `GOCD_PASSWORD_ENCRYPTED` is added to the image as the root credentials to log into GoCD.

I found its best to encrypt the password using the jar provided by the [file based login plugin](https://github.com/gocd/gocd-filebased-authentication-plugin#generating-password-using-cli-app).

Github OAuth requires a public redirect URL, one can use [NGROK](https://ngrok.com/) to create a secure tunnel for Github to connect to your local docker container during evaluation:

```
ngrok http 8153
```

## Github Access

As far as I am aware GoCD does not have a means to pull repos using GH credentials or Personal access tokens.

Create a RSA key in the folder `./stack/keys`. They will be symlinked into each container to allow the `server` and `agent` to pull private repos from github.

## Configure Plugins

Configures the plugins using the GoCD plugin settings API. Configuration is completed via shell scripts run by `./bin/gocd/configure-plugins.sh` with the configs defined in `./stack/containers/server/plugin-config`.

Go CD Slack plugin has a complicated configuration and is configured with the conf file `./stack/containers/server/config/go_notify.conf`.
