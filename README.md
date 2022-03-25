# **geoff**
A library of common code used in our projects


# **Installing**
Currently, geoff is only available on git. To install, add this to your `pubspec.yaml` under `dependancies`:
```
geoff:
    git: https://github.com/Kibibibit/geoff.git

```

Then, as this package depends on `flutter_appauth` (Can be found [here](https://pub.dev/packages/flutter_appauth)), you will need to add the following to your `android/app/build.grade` under `defaultConfig`:
```
manifestPlaceholders = [
    'appAuthRedirectScheme': '[your.custom.path].appauth'
]
```
If you are using keycloak, your clientId will need this path added to its' valid re-direct urls.


# **Libraries**
## **Models**
Currently nothing in here, will contain abstract data models

## **Utils**
Contains utility functions for all sorts of Networking, System and Maths tools
### **Maths**
Contains a random utils for now. Will add more
### **Networking**
Contains a GRPC client, RESTful api helpers, and a status code mapping, and authentication
### **System**
Contains an extension of the dart logger, and some system info utils

## **Widgets**
Currently empty, will contain some common widgets we use

---

## **Changelog**
Available [here](https://github.com/Kibibibit/geoff/blob/main/CHANGELOG.md)!


## **Credits**
This package uses work from a lot of people, so I want to credit every dependancy used in this package here:

- [Flutter App Auth](https://pub.dev/packages/flutter_appauth) by [dexterx.dev](https://pub.dev/publishers/dexterx.dev/packages)
- [Native Device Orientation](https://pub.dev/packages/native_device_orientation) by Unverified Uploader (Come on man I wanna credit you!)
- [Jaguar JWT](https://pub.dev/packages/jaguar_jwt) by another Unverified Uploader