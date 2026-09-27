class TrackModel {
  final String id;
  final String title;
  final String artist;
  final int duration;
  final bool isStreamable;
  final String? artwork;

  TrackModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.isStreamable,
    required this.artwork,
  });

  factory TrackModel.fromjson(Map<String, dynamic> json) {
    return TrackModel(
      id: json['id']?.toString() ?? "",
      title: json['title']?.toString() ?? "",
      artist: json['artist']?.toString() ?? "",
      duration: json['duration'] ?? 0,
      isStreamable: json['isStreamable'] ?? false,
      artwork: json['artwork']?['480x480'],
    );
  }
}
