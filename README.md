# **geoff**
A library of common code used in our projects


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

# **Changelog**
## **Version 0.1**
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
