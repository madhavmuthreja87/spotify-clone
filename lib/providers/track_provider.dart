import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sf/track_model.dart';

class TrackProvider extends ChangeNotifier {
  final AudioPlayer player = AudioPlayer();
  TrackModel? currentSong;

  bool isPlaying = false;

  Future<void> setSongAndPlay(TrackModel song) async {
    currentSong = song;
    notifyListeners();
    // await player.setUrl(song.streamUrl.toString());
    // await player.stop();
    // await player.play();

    await player.setUrl(song.streamUrl.toString());
    // await player.stop();
    await player.play();
    isPlaying = true;
    notifyListeners();
  }

  Future<void> pause() async {
    await player.pause();
    isPlaying = false;
    notifyListeners();
  }

  Future<void> resume() async {
    await player.play();

    isPlaying = true;
    notifyListeners();
  }

  Future<void> stop() async {
    await player.stop();

    isPlaying = false;
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    player.dispose();
    super.dispose();
  }
}
