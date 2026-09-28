import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sf/providers/track_provider.dart';
import 'package:sf/track_model.dart';

class PlayerScreen extends StatefulWidget {
  final TrackModel song;

  // final VoidCallback onPlayPause;

  const PlayerScreen({super.key, required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  String FormatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);

    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final tracker = context.watch<TrackProvider>();
    final player = tracker.player;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 83, 81, 81),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        titleSpacing: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Recommended for you",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Hero(
        tag: widget.song.id,
        curve: Curves.easeInToLinear,
        child: Container(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Card(
                      elevation: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.song.artwork!,
                          fit: BoxFit.cover,
                          height: 320,
                          width: 340,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.song.title.length > 18
                                  ? widget.song.title.substring(0, 18) + "..."
                                  : widget.song.title,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.auto_awesome_rounded,
                                  color: const Color.fromARGB(255, 94, 209, 98),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Not set",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.add_circle_outline_rounded,
                              color: Colors.white,
                              size: 37,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 23),
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: StreamBuilder<Duration>(
                            stream: player.positionStream,
                            builder: (context, snapshot) {
                              final position = snapshot.data ?? Duration.zero;
                              final duration = player.duration ?? Duration.zero;
                              return Column(
                                children: [
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      overlayShape:
                                          SliderComponentShape.noOverlay,
                                      trackShape:
                                          const RoundedRectSliderTrackShape(),
                                      thumbColor: Colors.white,
                                      inactiveTrackColor: Colors.grey,
                                      activeTrackColor: Colors.white,
                                      trackHeight: 1.5,

                                      thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 5,
                                      ),
                                    ),

                                    child: Slider(
                                      min: 0,
                                      max: duration.inSeconds.toDouble(),
                                      value: position.inSeconds
                                          .toDouble()
                                          .clamp(
                                            0,
                                            duration.inSeconds.toDouble(),
                                          ),
                                      onChanged: (value) {
                                        player.seek(
                                          Duration(seconds: value.toInt()),
                                        );
                                      },
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 7.0,
                                      vertical: 1,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          FormatDuration(position),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          FormatDuration(duration),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.shuffle_rounded,
                          size: 28,
                          color: Colors.white,
                        ),

                        Row(
                          children: [
                            Icon(
                              Icons.skip_previous_rounded,
                              size: 45,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 10),

                            GestureDetector(
                              onTap: () {
                                if (tracker.isPlaying) {
                                  tracker.pause();
                                } else {
                                  tracker.resume();
                                }
                              },
                              child: Icon(
                                tracker.isPlaying
                                    ? Icons.pause_circle_sharp
                                    : Icons.play_circle_sharp,
                                size: 75,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(width: 10),
                            Icon(
                              Icons.skip_next_rounded,
                              size: 45,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Icon(
                          Icons.timer_outlined,
                          size: 28,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
