import 'package:geoff/utils/system/log.dart';
import 'package:native_device_orientation/native_device_orientation.dart';


class DeviceOrientation {

  static final Log _logger = Log("OrientationUtils");

  static void disableColors() {
    _logger.setColors(false);
  }

  static Orientation _orientation = Orientation.unknown;

  /// Get the current orientation of the device. If initOrientation has not been called this will be unknown
  static Orientation get orientation {return _orientation;}

  /// Callback called when the orientation change 
  static void Function(Orientation orientation) onOrientationChange = ((orientation) {});


  /// Call this in an initState near the start of your app
  static void initOrientation({bool useSensor = true}) {

    NativeDeviceOrientationCommunicator communicator = NativeDeviceOrientationCommunicator();
    communicator.onOrientationChanged(useSensor: useSensor).listen((NativeDeviceOrientation nativeOrientation) {

      late Orientation orientation;

      switch (nativeOrientation) {
        
        case NativeDeviceOrientation.portraitUp:
          orientation = Orientation.potraitUp;
          break;
        case NativeDeviceOrientation.portraitDown:
          orientation = Orientation.potraitDown;
          break;
        case NativeDeviceOrientation.landscapeLeft:
          orientation = Orientation.landscapeLeft;
          break;
        case NativeDeviceOrientation.landscapeRight:
          orientation = Orientation.landscapeRight;
          break;
        case NativeDeviceOrientation.unknown:
          orientation = Orientation.unknown;
          break;
      }
      _orientation = orientation;
      onOrientationChange(orientation);

      _logger.debug(orientation);
    });

  }

}

enum Orientation {
  potraitUp,
  potraitDown,
  landscapeLeft,
  landscapeRight,
  unknown
}