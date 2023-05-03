wget -o emagapi.json https://backoffice.emag23.nl/api/doc.json
java -jar openapi-generator-cli.jar generate -i https://backoffice.emag23.nl/api/doc.json -g dart -o ./