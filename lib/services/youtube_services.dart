import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeServices {
  final YoutubeExplode _yt=YoutubeExplode();

  Future<List<Video>> searchFromYoutube(String query) async{
      final results=await _yt.search(query);
      return results.toList();
  }

  Future<String> getAudioUrl(String videoId) async{
    final manifest=await _yt.videos.streams.getManifest(videoId);
    final audio=manifest.audioOnly.withHighestBitrate();
    return audio.url.toString();

  }

  void dispose()=> _yt.close();
}