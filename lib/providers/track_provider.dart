import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';

import 'package:sf/audio_handler.dart';
import 'package:sf/audis_api.dart';
import 'package:sf/models/track_model.dart';

class TrackProvider extends ChangeNotifier {
  // The handler owns the real player, so the notification, lock screen
  // and in-app controls all control the same thing.
  final MyAudioHandler handler;
  AudioPlayer get player => handler.player;

  TrackModel? currentSong;
  bool isPlaying = false;

  List<TrackModel> trendingSongsList = [];
  List<TrackModel> latestSongsList = [];

  final Box recentBox = Hive.box("recentSongs");
  final Box likedBox = Hive.box("likedSongs");
  final Box playlistBox = Hive.box("playlistBox");
  final Box mostPlayedBox = Hive.box("mostPlayedBox");

  TrackProvider(this.handler) {
    player.playingStream.listen((playing) {
      isPlaying = playing;
      notifyListeners();
    });
  }

  // DEBUG ONLY: clears the box. Never call this in release builds.
  Future<void> addTemporaryMostPlayedData() async {
    await mostPlayedBox.clear();

    await mostPlayedBox.put('song1', {
      'id': 'song1',
      'title': 'Blinding Lights',
      'artist': 'The Weeknd',
      'duration': 200,
      'is_streamable': 'true',
      'artwork': 'https://picsum.photos/300?1',
      'streamUrl': 'https://example.com/song1.mp3',
      'playCount': 1,
    });

    await mostPlayedBox.put('song2', {
      'id': 'song2',
      'title': 'Starboy',
      'artist': 'The Weeknd',
      'duration': 230,
      'is_streamable': 'true',
      'artwork': 'https://picsum.photos/300?2',
      'streamUrl': 'https://example.com/song2.mp3',
      'playCount': 1,
    });

    await mostPlayedBox.put('song3', {
      'id': 'song3',
      'title': 'Shape of You',
      'artist': 'Ed Sheeran',
      'duration': 234,
      'is_streamable': 'true',
      'artwork': 'https://picsum.photos/300?3',
      'streamUrl': 'https://example.com/song3.mp3',
      'playCount': 1,
    });

    await mostPlayedBox.put('song4', {
      'id': 'song4',
      'title': 'Perfect',
      'artist': 'Ed Sheeran',
      'duration': 263,
      'is_streamable': 'true',
      'artwork': 'https://picsum.photos/300?4',
      'streamUrl': 'https://example.com/song4.mp3',
      'playCount': 1,
    });

    await mostPlayedBox.put('song5', {
      'id': 'song5',
      'title': 'Believer',
      'artist': 'Imagine Dragons',
      'duration': 204,
      'is_streamable': 'true',
      'artwork': 'https://picsum.photos/300?5',
      'streamUrl': 'https://example.com/song5.mp3',
      'playCount': 1,
    });

    await mostPlayedBox.put('song6', {
      'id': 'song6',
      'title': 'Thunder',
      'artist': 'Imagine Dragons',
      'duration': 187,
      'is_streamable': 'true',
      'artwork': 'https://picsum.photos/300?6',
      'streamUrl': 'https://example.com/song6.mp3',
      'playCount': 1,
    });

    await mostPlayedBox.put('song7', {
      'id': 'song7',
      'title': 'OK',
      'artist': 'The Weeknd',
      'duration': 200,
      'is_streamable': 'true',
      'artwork': 'https://picsum.photos/300?1',
      'streamUrl': 'https://example.com/song1.mp3',
      'playCount': 2,
    });

    notifyListeners();
  }

  Future<void> setSongAndPlay(TrackModel song) async {
    try {
      currentSong = song;
      notifyListeners();

      // Feeds the notification, lock screen and Dynamic Island.
      handler.mediaItem.add(
        MediaItem(
          id: song.id.toString(),
          title: song.title.toString(),
          artist: song.artist.toString(),
          artUri: Uri.tryParse('${song.artwork ?? ''}'),
          duration: Duration(
            seconds: int.tryParse(song.duration.toString()) ?? 0,
          ),
        ),
      );

      await saveRecentSongs(song);

      // First try the URL we already have.
      // String? url = song.streamUrl;

      // if (url == null || url.isEmpty) {
      //   throw Exception("Stream URL is empty");
      // }

      try {
        //   // Fast path
        //   await player.setUrl(url);
        //   await player.play();

        //   isPlaying = true;
        //   notifyListeners();
        // } catch (e) {
        log("Getting fresh URL...");

        // URL may have expired -> get a new signed URL
        final freshUrl = await AudisApi().getFreshStreamUrl(song.id);
        await player.setUrl(freshUrl);
        await player.play();

        isPlaying = true;
        notifyListeners();
        // Only count after successful playback
        await recordSongPlayedCount(song);
      } catch (e) {
        log("$e");
      }
    } catch (e, st) {
      log("PLAY ERROR: $e");
      log("$st");

      isPlaying = false;
      notifyListeners();
    }
  }

  Future<void> pause() async {
    isPlaying = false;
    notifyListeners();
    await handler.pause();
  }

  Future<void> resume() async {
    isPlaying = true;
    notifyListeners();
    await handler.play();
  }

  Future<void> stop() async {
    isPlaying = false;
    notifyListeners();
    await handler.stop();
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

  Future<void> recordSongPlayedCount(TrackModel song) async {
    // Fixed: the box stores a Map, not an int, so read playCount from it.
    final existing = mostPlayedBox.get(song.id);
    final currentCount = existing == null
        ? 0
        : (existing['playCount'] as int? ?? 0);

    await mostPlayedBox.put(song.id, {
      'id': song.id,
      'title': song.title,
      'artist': song.artist,
      'duration': song.duration,
      'is_streamable': song.isStreamable,
      'artwork': song.artwork,
      'streamUrl': song.streamUrl,
      'playCount': currentCount + 1,
    });

    notifyListeners();
  }

  Future<void> fetchTrendingSongs() async {
    try {
      trendingSongsList = await AudisApi().getTrendingTracks();

      notifyListeners();
    } catch (e) {
      print("Error fetching trending songs: $e");
    }
  }

  List<TrackModel> trendingSongs() {
    return trendingSongsList;
  }

  Future<void> fetchLatestSongs() async {
    try {
      latestSongsList = await AudisApi().getLatestTracks();

      notifyListeners();
    } catch (e) {
      print("Error fetching trending songs: $e");
    }
  }

  List<TrackModel> LatestSongs() {
    return latestSongsList;
  }

  List<Map> mostPlayedSong() {
    final songs = mostPlayedBox.values
        .map((song) => Map<String, dynamic>.from(song))
        .toList();

    songs.sort(
      (a, b) => (b['playCount'] as int).compareTo(a['playCount'] as int),
    );

    return songs.take(7).toList();
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

    // Added: refresh the UI after liking a song.
    notifyListeners();
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

  // Playlist creation and adding songs into it
  Future<void> createPlaylist(String pname) async {
    await playlistBox.put(pname, []);
    notifyListeners();
  }

  Future<void> removePlaylist(String pname) async {
    await playlistBox.delete(pname);
    notifyListeners();
  }

  Future<void> addToPlaylist(String pname, TrackModel tm) async {
    final playlist = playlistBox.get(pname, defaultValue: <Map>[]);

    final existingPlaylist = List<Map>.from(playlist);

    existingPlaylist.add({
      'id': tm.id,
      'title': tm.title,
      'artist': tm.artist,
      'duration': tm.duration,
      'is_streamable': tm.isStreamable,
      'artwork': tm.artwork,
      'streamUrl': tm.streamUrl,
    });

    await playlistBox.put(pname, existingPlaylist);

    notifyListeners();
  }

  Future<void> removeFromPlaylist(String pname, String songID) async {
    final stored = playlistBox.get(pname, defaultValue: <Map>[]);

    if (stored == null) return;

    // Copy into a fresh typed list before modifying.
    final existingPlaylist = List<Map>.from(stored);
    existingPlaylist.removeWhere((song) => song['id'] == songID);

    await playlistBox.put(pname, existingPlaylist);

    notifyListeners();
  }

  List<String> allplaylistsName() {
    final playlist = playlistBox.keys.cast<String>().toList();

    return playlist;
  }

  List<Map> songsOfPlaylist(String pname) {
    return List<Map>.from(playlistBox.get(pname, defaultValue: <Map>[]));
  }

  @override
  void dispose() {
    // The handler owns the player, so don't dispose it here.
    super.dispose();
  }
}
