import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sf/providers/track_provider.dart';
import 'package:sf/screens/player_screen.dart';
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlayerScreen(song: song)),
        );
      },
      child: Container(
        height: 60,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(color: Colors.black45),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    song.artwork ?? "",
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  children: [
                    Text(
                      song.title.length > 20
                          ? song.title.substring(0, 20) + "..."
                          : song.title,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(song.artist),
                  ],
                ),
              ],
            ),

            Row(
              children: [
                IconButton(
                  onPressed: () {
                    log("pause pressed");
                    onPlayPause();
                  },
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
