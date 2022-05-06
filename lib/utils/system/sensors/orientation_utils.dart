import 'package:geoff/utils/system/log.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

/// Contains utilities for getting the orientation of the device
abstract class DeviceOrientation {

  DeviceOrientation._();

  static final Log _logger = Log("OrientationUtils");

  /// Disable the colors in the logs if your terminal does not support escape codes
  static void disableColors() {
    _logger.setColors(false);
  }

  static EOrientation _orientation = EOrientation.unknown;

  /// Get the current orientation of the device. If initOrientation has not been called this will be unknown
  static EOrientation get orientation {return _orientation;}

  /// Callback called when the orientation change 
  static void Function(EOrientation orientation) onOrientationChange = ((orientation) {});


  /// Call this in an initState near the start of your app
  static void initOrientation({bool useSensor = true}) {

    NativeDeviceOrientationCommunicator communicator = NativeDeviceOrientationCommunicator();
    communicator.onOrientationChanged(useSensor: useSensor).listen((NativeDeviceOrientation nativeOrientation) {

      late EOrientation orientation;

      switch (nativeOrientation) {
        
        case NativeDeviceOrientation.portraitUp:
          orientation = EOrientation.portraitUp;
          break;
        case NativeDeviceOrientation.portraitDown:
          orientation = EOrientation.portraitDown;
          break;
        case NativeDeviceOrientation.landscapeLeft:
          orientation = EOrientation.landscapeLeft;
          break;
        case NativeDeviceOrientation.landscapeRight:
          orientation = EOrientation.landscapeRight;
          break;
        case NativeDeviceOrientation.unknown:
          orientation = EOrientation.unknown;
          break;
      }
      _orientation = orientation;
      onOrientationChange(orientation);
    });

  }

}

enum EOrientation {
  portraitUp,
  portraitDown,
  landscapeLeft,
  landscapeRight,
  unknown
}