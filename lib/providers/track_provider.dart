import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sf/track_model.dart';

class TrackProvider extends ChangeNotifier {
  final AudioPlayer player = AudioPlayer();
  TrackModel? currentSong;

  bool isPlaying = false;

  final Box recentBox = Hive.box("recentSongs");
  final Box likedBox = Hive.box("likedSongs");

  TrackProvider() {
    player.playingStream.listen((playing) {
      isPlaying = playing;
      notifyListeners();
    });
  }

  Future<void> setSongAndPlay(TrackModel song) async {
    currentSong = song;
    notifyListeners();
    // await player.setUrl(song.streamUrl.toString());
    // await player.stop();
    // await player.play();
    await saveRecentSongs(song);
    notifyListeners();

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
    isPlaying = true;
    notifyListeners();
    await player.play();

    notifyListeners();
  }

  Future<void> stop() async {
    isPlaying = false;
    notifyListeners();
    await player.stop();

    notifyListeners();
  }

  Future<void> saveRecentSongs(TrackModel song) async {
    await recentBox.delete(song.id);
    await recentBox.put(song.id, {
      'id': song.id,
      'title': song.title,
      'artist': song.artist,
      'duration': song.duration,
      'is_streamable': song.isStreamable,
      'artwork': song.artwork,
      'streamUrl': song.streamUrl,
      'playedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  List<Map> recentSongs() {
    final songs = recentBox.values
        .map((song) => Map<String, dynamic>.from(song))
        .toList();

    songs.sort((a, b) => b['playedAt'].compareTo(a['playedAt']));

    return songs;
  }

  Future<void> removeRecentSong(String songID) async {
    await recentBox.delete(songID);
    notifyListeners();
  }

  Future<void> removeAllrecentSong() async {
    await recentBox.clear();
    notifyListeners();
  }

  Future<void> saveLikedSongs(TrackModel song) async {
    await likedBox.put(song.id, {
      'id': song.id,
      'title': song.title,
      'artist': song.artist,
      'duration': song.duration,
      'is_streamable': song.isStreamable,
      'artwork': song.artwork,
      'streamUrl': song.streamUrl,
    });
  }

  List<Map> likedSongs() {
    final songs = likedBox.values
        .map((song) => Map<String, dynamic>.from(song))
        .toList();

    return songs;
  }

  Future<void> removeLikedSong(String songID) async {
    await likedBox.delete(songID);
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    player.dispose();
    super.dispose();
  }
}
