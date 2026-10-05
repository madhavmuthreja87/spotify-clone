import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notch/notch.dart';
import 'package:provider/provider.dart';
import 'package:sf/providers/track_provider.dart';

class NotchPlayer extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final tracker = context.watch<TrackProvider>();
    final song = tracker.currentSong;

    return NotchEmerge(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (song?.artwork != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    song!.artwork!,
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(width: 8),

              Flexible(
                child: Text(
                  song!.title,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(width: 8),

              Icon(
                tracker.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
