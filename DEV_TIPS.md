# EMAG '23 scanner developer tips and stuff

## Getting started
How should i build this application?

### To generate JSON serializable classes:
```shell
dart run build_runner build --delete-conflicting-outputs
```

### To generate new realms schema:
```shell
flutter pub run realm generate
```
### To build new images for the native splash screens for both android and iOS:
```shell
flutter pub run flutter_native_splash:create --path=flutter_native_splash.yaml 
```

### To re-generate the localization strings:
```shell
flutter gen-l10n
```
,
    "" : "",
    "@":{
        "description":""
    }

### To generate icons
``` shell
flutter pub run flutter_launcher_icons
```

### (Re)generate or update api's
- If needed, download the [OpenAPI Generator CLI](https://openapi-generator.tech/docs/installation/) [^1]
- Open a terminal
- **Important** change directory to ...../apis/\<api\>
- Check the proper paths in `create-api.sh`, i.e. the path to your `openapi-generator-cli.jar` and match the command with the generator you downloaded.
- Run the generator, options are in the files `open-generator-config.yaml`
- Run the command(s) from create-api.sh [^2] 


[^1]: The api's were generated with version 6.5.0.

[^2]: Take special note about the command `dart run build_runner build` to run after an API is generated. This wil re-create the generated files to complete the API. If prompted, delete previously generated files `*.g.dart` (you can check which files it will delete and re-create)

### Debug over WiFi
- make sure both development machine and device are connected to same WiFi and that the router allows communication between WiFi devices
- connect device to USB
```shell
adb devices
adb tcpip 5555
```
- disconnect device from USB
``` shell
adb connect <device_ip_address>
```
- select device from list of available devices