import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sf/providers/track_provider.dart';
import 'package:sf/models/track_model.dart';

class AddToPlaylist extends StatefulWidget {
  final String pname;
  const new({super.key, required this.pname});

  @override
  State<AddToPlaylist> createState() => _AddToPlaylistState();
}

class _AddToPlaylistState extends State<AddToPlaylist> {
  @override
  Widget build(BuildContext context) {
    //   final tracker = context.watch<TrackProvider>();
    //  final inplayistsongs = context.read<TrackProvider>().songsOfPlaylist;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Add to this playlist",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(36, 247, 247, 247),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<TrackProvider>(
              builder: (context, tracker, child) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tracker.recentSongs().length,
                    itemBuilder: (context, index) {
                      final recentContent = tracker.recentSongs()[index];

                      final bool isinplaylist = tracker
                          .songsOfPlaylist(widget.pname)
                          .any((song) => song['id'] == recentContent['id']);

                      TrackModel currentTrack = TrackModel(
                        id: recentContent['id'] ?? "",
                        title: recentContent['title'] ?? "",
                        artist: recentContent['artist'] ?? "",
                        duration: recentContent['duration'] ?? "",
                        isStreamable: recentContent['is_streamable'] ?? "",
                        artwork: recentContent['artwork'] ?? "",
                        streamUrl: recentContent['streamUrl'] ?? "",
                      );

                      return GestureDetector(
                        onTap: () {
                          context.read<TrackProvider>().setSongAndPlay(
                            TrackModel(
                              id: recentContent['id'] ?? "",
                              title: recentContent['title'] ?? "",
                              artist: recentContent['artist'] ?? "",
                              duration: recentContent['duration'] ?? "",
                              isStreamable: recentContent['isStreamable'] ?? "",
                              artwork: recentContent['artwork'] ?? "",
                              streamUrl: recentContent['streamUrl'] ?? "",
                            ),
                          );
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            // child: Image.network(
                            //   recentContent['artwork'],
                            //   fit: BoxFit.cover,
                            //   height: 47,
                            //   width: 47,
                            // ),
                            child: CachedNetworkImage(
                              imageUrl: recentContent['artwork'],
                              fit: BoxFit.cover,
                              height: 47,
                              width: 47,
                            ),
                          ),
                          title: Text(
                            recentContent['title'],
                            maxLines: 1,

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            recentContent['artist'],
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () async {
                                  if (!isinplaylist) {
                                    await tracker.addToPlaylist(
                                      widget.pname,
                                      currentTrack,
                                    );
                                    log("Add to   ${widget.pname}   playist");
                                  } else {
                                    await tracker.removeFromPlaylist(
                                      widget.pname,
                                      currentTrack.id,
                                    );
                                    log(
                                      "Removed from   ${widget.pname}   playist",
                                    );
                                  }
                                  setState(() {});

                                  log(
                                    tracker
                                        .songsOfPlaylist(widget.pname)
                                        .toList()
                                        .length
                                        .toString(),
                                  );
                                  // log("Like the song pressed");

                                  // if (!isLiked)
                                  //   await tracker.saveLikedSongs(currentTrack);
                                  // else
                                  //   await tracker.removeLikedSong(currentTrack.id);

                                  // setState(() {});

                                  // log(tracker.likedSongs().length.toString());
                                },
                                child: !isinplaylist
                                    ? Icon(
                                        Icons.add_circle_outline,
                                        color: const Color.fromARGB(
                                          255,
                                          118,
                                          118,
                                          118,
                                        ),
                                        size: 28,
                                      )
                                    : Icon(
                                        Icons.check_circle,
                                        color: const Color.fromARGB(
                                          255,
                                          92,
                                          214,
                                          96,
                                        ),
                                        size: 28,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
