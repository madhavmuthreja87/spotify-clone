import 'package:overlay_pop_up/overlay_pop_up.dart';

class OverlayService {
  static Future<bool> requestPermission() async {
    return await OverlayPopUp.requestPermission();
  }

  static Future<bool> show() async {
    return await OverlayPopUp.showOverlay(
      width: 220,
      height: 70,
      isDraggable: false,
      notificationIcon: "ic_launcher",
      notificationTitle: "Spotify",
      notificationText: "Player is active",
      entryPointMethodName: "overlayPopUp",
    );
  }

  static Future<void> close() async {
    await OverlayPopUp.closeOverlay();
  }
}
