import 'dart:developer';

class TrackModel {
  final String id;
  final String title;
  final String artist;
  final int duration;
  final String isStreamable;
  final String? artwork;
  final String? streamUrl;

  TrackModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.isStreamable,
    required this.artwork,
    required this.streamUrl,
  });

  factory TrackModel.fromjson(Map<String, dynamic> json) {
    return TrackModel(
      id: json['id']?.toString() ?? "",
      title: json['title']?.toString() ?? "",
      artist: json['artist']?.toString() ?? "",
      duration: json['duration'] ?? 0,
      isStreamable: json['is_streamable']?.toString() ?? "",
      artwork: json['artwork']?['480x480'],
      streamUrl: json['stream']?['url'],
    );
  }
}
