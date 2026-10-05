import 'package:flutter/widgets.dart';
import 'package:live_activity_kit/live_activity_kit.dart';
import 'package:sf/models/track_model.dart';

class PlaybackActivityService {
  static const String _activityID = "sf";

  //start a new live activity for the current song
  static Future<void> start(TrackModel song, bool isPlaying) async {
    await LiveActivity.show(
      id: _activityID,

      //Dynamic Island - Comapct leading area
      compactLeading: LA.text("♫"),
      //Dynamic Island - compact trailing area
      compactTrailing: LA.text(isPlaying ? '▶' : '❚❚'),

      //Dynamic Island expanded view
      expanded: LA.column([
        LA.row([
          LA.text(song.title, size: 16, weight: FontWeight.bold),
          LA.spacer(),
          LA.text(song.artist, size: 13),
        ]),
      ]),

      //Lock screen live activity
      lockScreen: LA.row([
        if (song.artwork != null && song.artwork!.isNotEmpty)
          LA.networkImage(song.artwork!, width: 55, height: 55),
        LA.column([
          LA.text(song.title, size: 16),
          LA.text(song.id, size: 13),
          LA.text(isPlaying ? "playing..." : "paused", size: 12),
        ]),
      ]),
    );
  }

  //update the existing Live activity
  static Future<void> update(TrackModel song, bool isplaying) async {
    await LiveActivity.update(
      id: _activityID,

      //Dynamic Island - Comapct leading area
      compactLeading: LA.text("♫"),
      //Dynamic Island - compact trailing area
      compactTrailing: LA.text(isplaying ? '▶' : '❚❚'),

      //Dynamic Island expanded view
      expanded: LA.column([
        LA.row([
          LA.text(song.title, size: 16, weight: FontWeight.bold),
          LA.spacer(),
          LA.text(song.artist, size: 13),
        ]),
      ]),

      //Lock screen live activity
      lockScreen: LA.row([
        if (song.artwork != null && song.artwork!.isNotEmpty)
          LA.networkImage(song.artwork!, width: 55, height: 55),
        LA.column([
          LA.text(song.title, size: 16),
          LA.text(song.id, size: 13),
          LA.text(isplaying ? "playing..." : "paused", size: 12),
        ]),
      ]),
    );
  }

  static Future<void> end() async {
    await LiveActivity.end(id: _activityID);
  }
}
