wget -o emagapi.json https://backoffice.emag23.nl/api/doc.json
java -jar c:/jars/openapi-generator-cli.jar generate -i https://backoffice.emag23.nl/api/doc.json -g dart -o ./ -c open-generator-config.yaml
flutter pub upgrade
dart run build_runner build