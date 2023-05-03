wget -o registrationapi.json http://localhost/api/doc.json
java -jar openapi-generator-cli.jar generate -i http://localhost/api/doc.json -g dart -o ./