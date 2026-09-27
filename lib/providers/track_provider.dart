import 'package:flutter/widgets.dart';
import 'package:sf/track_model.dart';

class TrackProvider extends ChangeNotifier {
  TrackModel? currentSong;

  bool isPlaying = false;

  void setSong(TrackModel song) {
    currentSong = song;
    isPlaying = true;

    notifyListeners();
  }

  void pause() {
    isPlaying = false;
    notifyListeners();
  }

  void resume() {
    isPlaying = true;
    notifyListeners();
  }
}
