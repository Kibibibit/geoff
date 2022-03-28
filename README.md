# **geoff**
A library of common code used in our projects


# **Installing**
Currently, geoff is only available on git. To install, add this to your `pubspec.yaml` under `dependancies`:
```yaml
geoff:
    git: https://github.com/Kibibibit/geoff.git

```

Then, as this package depends on `flutter_appauth` (Can be found [here](https://pub.dev/packages/flutter_appauth)), you need to update some of the build files.
## Android Setup
You will need to add the following to your `android/app/build.gradle` under `defaultConfig`:
```gradle
...
android {
    ...
    defaultConfig {
        ...
        manifestPlaceholders += [
                'appAuthRedirectScheme': '<your_custom_scheme>'
        ]
    }
}
```
`<your_custom_scheme>` must be in all lowercase. Also notice the use of `+=`, this is required by newer versions of the flutter SDK.

If your app is target API 30 or above (i.e. Android 11 or newer), make sure to add the following to your `AndroidManifest.xml` file a level underneath the `<manifest>` element
```xml
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="https" />
    </intent>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.APP_BROWSER" />
        <data android:scheme="https" />
    </intent>
</queries>
```
Instructions taken from [here](https://pub.dev/packages/flutter_appauth#android-setup)

## iOS Setup

You will need to update your `Info.plist` to include the following:
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>your_custom_scheme</string>
        </array>
    </dict>
</array>
```
Instructions taken from [here](https://pub.dev/packages/flutter_appauth#ios-setup)

## Keycloak

If you are using keycloak, your clientId will need this path added to its' valid re-direct urls.


# **Usage**

There are usage examples for all libraries over on the [wiki](https://github.com/Kibibibit/geoff/wiki)!.

Some basic examples however are:
### Logger
```dart
class _MyWidgetState extends State<MyWidget> {
  final Log _logger = Log("MyWidget");
  ...
  @override
  void initState() {
      _logger.info("Doing an info!");
      _logger.logAt(Level.warning, "Doing a warning!");
      ...
  }

```

### Alarm
```dart

Alarm alarm = Alarm.after(Duration(seconds:10), () {
    _logger.info("Alarm went off after 10 seconds!");
});

alarm.start();
// This will now trigger after 10 seconds

Alarm alarm2 = Alarm.at(DateTime.now().add(Duration(seconds:10)), () {
    _logger.info("Alarm went off!");
});

alarm2.start();
// This alarm will go off 10 seconds after it was created.
// Note that if 10 seconds have already passed, it will go off immediatly
```

---

## **Changelog**
Available [here](https://github.com/Kibibibit/geoff/blob/main/CHANGELOG.md)!


## **Credits**
This package uses work from a lot of people, so I want to credit every dependancy used in this package here:

- [Flutter App Auth](https://pub.dev/packages/flutter_appauth) by [dexterx.dev](https://pub.dev/publishers/dexterx.dev/packages)
- [Native Device Orientation](https://pub.dev/packages/native_device_orientation) by Unverified Uploader (Come on man I wanna credit you!)
- [Jaguar JWT](https://pub.dev/packages/jaguar_jwt) by another Unverified Uploader