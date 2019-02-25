# Veracode Tools Docker Image

Docker image with all Veracode tools pre-installed. This is not an official Veracode project, Veracode support will not be able to provide assistance with issues.

    docker pull ctcampbellcom/veracode-tools

## Java API Wrapper

    docker run -it -v ~/.veracode:/root/.veracode ctcampbellcom/veracode-tools java -jar veracode-wrapper.jar

## Python/HTTPie

    docker run -it -v ~/.veracode:/root/.veracode --rm ctcampbellcom/veracode-tools http -A veracode_hmac https://api.veracode.com/appsec/v1/applications

## SourceClear

    docker run -it -v ~/.veracode:/root/.veracode --env SRCCLR_API_TOKEN=eyJhbGciOi... veracode-tools srcclr scan
