# **Changelog**

## **Version 0.2**

### **0.2.10**
- Updated `http` to version 1.0.0
### **0.2.9**
- Fixed a bug with `SystemInfo.getPlatform`

### **0.2.8**
- Temporarily removed colors from mac and ios logging, as the mac terminal does not support ANSI escape codes
- Updated `bodyText2` to `bodyMedium` in `GrepText` to reflect latest flutter updates

### **0.2.7**
- Updated `flutter_appauth` to the latest version (`4.2.0`)

### **0.2.6**
- Added the `Debouncer` class

### Released on pub.dev!

### **0.2.5**
- Changed a bunch of classes with only `static` methods to be `abstract` and added private constructors to prevent extending
- Added the `functional` library, which contains a few funtional programming methods.
- Added `time` library with some utc helpers.

Finally adding stuff to the `models` package this update!
- Added `GeoffUser` and `KeycloakUser`
- Added `ModelUtils`
- Added `BadTypeException` and `MissingFieldException`
- Added the `RichTextBlock` model, which can be used to output rich text with html tags! Currently no editor for it, maybe down the line I'll do that

### **0.2.4**
- Re-wrote `MayRest` to reduce code duplication
- `MayRest` calls can now be manually given a token
- Added `patch` to `MayRest`
- Added `GrepText` to widgets
- Increased default `maxLogs` in `Log` to 1000
- Added `GrepText` based searching into the logger

### **0.2.3**
- Readme updates
- Added `wrapInt` and `wrapDouble` to number utils
- Added `doubleInRange` and made changes to `RandomUtils`
- Corrected name of GRPC Utils
- Default headers no longer const, so they can be modified
- Changed `debugMode` to a getter instead of a public field
### **0.2.2**
- Added the ability to copy logs to clipboard

### **0.2.1**
- Added a refresh token loop that can be triggered from `Session`
- Added Alarms
- Added the ability to log out
- Session and AppAuthHelper now more closely intertwined, no need to call both on login/logout

### **0.2.0**
- First proper release

## **Version 0.1**
### **0.1.9-fix-4**
- Adjusted the styling of the logger again
  
### **0.1.9-fix-3**
- Adjusted the styling of the logger

### **0.1.9-fix-2**
- Some colouring and styling changes

### **0.1.9-fix-1**
- Added bold to log console output label, also updated version to help with version stuff

### **0.1.9**
- Reformatting the log console output a bit

### **0.1.8-fix-8**
- After all this testing, I think I finally got the logger console working

### **0.1.8-testing-2**
- Doing some testing with versioning, hopefully will actually fix 0.1.8-fix-7

### **0.1.8-testing-1**
- Doing some testing with versioning

### **0.1.8-fix-7**
- Logger now shows all previous logs without needing a new one to update it - Actually this time *please actually work this is getting insane*

### **0.1.8-fix-6**
- Logger subscription now cancels on pop, just to ease the amount of listeners

### **0.1.8-fix-5**
- Logger now shows all previous logs without needing a new one to update it - Actually this time

### **0.1.8-fix-4**
- Logger now shows all previous logs without needing a new one to update it
- Added the ability to allow logs in production versions of the app through a flag

### **0.1.8-fix-3**
- Changed logger stream to a broadcast to allow multiple listeners

### **0.1.8-fix-2**
- Cancelled stream subscription after logger closes

### **0.1.8-fix**
- Fixed listview in logger expecting infinite items

### **0.1.8**
- Adding a logger console that can be popped up. Unstable currently.

### **0.1.7**
- Added Orientationutils, allowing checking and running callbacks on device orientation changes

### **0.1.6**
- Added number utils

### **0.1.5-fix-3**
- Export fixes
  
### **0.1.5-fix-2**
- Added scopes into app auth

### **0.1.5-fix**
- Made Session.onLogin static

### **0.1.5**
- Started adding app auth stuff

### **0.1.4-fix**
- Added a slight fix to the formatting in the logger

### **0.1.4-docs**
- Added documentation and some slight refactoring

### **0.1.4**
- Added the ability to disable colors on the logger

### **0.1.3**
- Added a random utils
- Rewrote the logger to not be so giant

### **0.1.2-fix**
- Fixed system info not being exported

### **0.1.2**
- Added put and delete to MayRest
- MayRest logger now changes level based on returned status code

### **0.1.1**
- Added StatusCode and SystemInfo

### **0.1.0**
- Added MayRest, GrpcUtils and Log

## **Vesion 0.0**
### **0.0.1**
- Project Creation
