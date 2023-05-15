wget -o registrationapi.json http://localhost:5001/swagger/v1/swagger.json
java -jar c:\\jars\\openapi-generator-cli.jar generate -i http://localhost:5001/swagger/v1/swagger.json -g dart-dio -o ./ -c open-generator-config.yaml
flutter pub upgrade
dart run build_runner build
