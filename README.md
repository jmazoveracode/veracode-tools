# Veracode Tools Docker Image

Docker image with all Veracode tools pre-installed. This is not an official Veracode project, Veracode support will not be able to provide assistance with issues.

    docker pull ctcampbellcom/veracode-tools

## Java API Wrapper

    docker run -it ctcampbellcom/veracode-tools java -jar veracode-wrapper.jar

## Python/HTTPie

Set up a local `~/.veracode/credentials` file with API credentials:

    [default]
    veracode_api_key_id = <YOUR_API_KEY_ID>
    veracode_api_key_secret = <YOUR_API_KEY_SECRET>

Then bind mount into the container:

    docker run -it -v ~/.veracode:/root/.veracode --rm ctcampbellcom/veracode-tools http -A veracode_hmac https://api.veracode.com/appsec/v1/applications
    
Or provide environment variables:

    docker run -it --env VERACODE_API_KEY_ID=shf389f3j... --env VERACODE_API_KEY_SECRET=sijfsnfsn... --rm ctcampbellcom/veracode-tools http -A veracode_hmac https://api.veracode.com/appsec/v1/applications

## SourceClear

    docker run -it --rm --env SRCCLR_API_TOKEN=eyJhbGciOi... veracode-tools srcclr scan
