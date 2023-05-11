wget -o registrationapi.json http://localhost/api/doc.json
java -jar openapi-generator-cli.jar -cp c:\\jars generate -i http://localhost/api/doc.json -g dart -o ./