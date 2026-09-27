import 'package:flutter/material.dart';
import 'package:sf/track_model.dart';

class MiniPlayer extends StatelessWidget {
  final TrackModel song;
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onTap;

  MiniPlayer({
    required this.song,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(color: Colors.black45),
      child: ListTile(
        leading: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Image.network(song.artwork ?? "", fit: BoxFit.cover),
        ),
        title: Text(song.title),
        subtitle: Text(song.artist),
        trailing: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }
}
