import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sf/providers/track_provider.dart';
import 'package:sf/track_model.dart';

class PlaylistHome extends StatefulWidget {
  final String pname;
  const PlaylistHome({super.key, required this.pname});

  @override
  State<PlaylistHome> createState() => _PlaylistHomeState();
}

class _PlaylistHomeState extends State<PlaylistHome> {
  @override
  Widget build(BuildContext context) {
    final tracker = context.read<TrackProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 117, 117, 117),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color.fromARGB(255, 117, 117, 117),
                              Colors.black,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Card(
                                    elevation: 15,
                                    child: Container(
                                      height:
                                          MediaQuery.sizeOf(context).height / 6,
                                      width:
                                          MediaQuery.sizeOf(context).height / 6,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF121212),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.pname,
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),

                                      TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                            135,
                                            131,
                                            131,
                                            131,
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          "change",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 7),

                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: const Icon(
                                  Icons.language_sharp,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                              ),

                              const SizedBox(height: 30),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.share_rounded,
                                    size: 30,
                                    color: Colors.grey,
                                  ),

                                  const SizedBox(width: 27),

                                  const Icon(
                                    Icons.more_vert,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      ///////////
                      const SizedBox(height: 50),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width / 1.7,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () {},
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_rounded,
                                    color: Colors.black,
                                    size: 35,
                                  ),
                                  Text(
                                    "Add to this playlist",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Recommended Songs",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      tracker.recentSongs().isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 4,
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: tracker.recentSongs().length,
                                itemBuilder: (context, index) {
                                  final recentContent = tracker
                                      .recentSongs()[index];

                                  final bool isLiked = tracker.likedSongs().any(
                                    (song) => song['id'] == recentContent['id'],
                                  );

                                  final TrackModel currentTrack = TrackModel(
                                    id: recentContent['id'] ?? "",
                                    title: recentContent['title'] ?? "",
                                    artist: recentContent['artist'] ?? "",
                                    duration: recentContent['duration'] ?? "",
                                    isStreamable:
                                        recentContent['is_streamable'] ?? "",
                                    artwork: recentContent['artwork'] ?? "",
                                    streamUrl: recentContent['streamUrl'] ?? "",
                                  );

                                  return GestureDetector(
                                    onTap: () {
                                      tracker.setSongAndPlay(currentTrack);
                                    },
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,

                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Image.network(
                                          recentContent['artwork'],
                                          fit: BoxFit.cover,
                                          height: 47,
                                          width: 47,
                                        ),
                                      ),

                                      title: Text(
                                        recentContent['title'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      subtitle: Text(
                                        recentContent['artist'],
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),

                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(width: 8),

                                          GestureDetector(
                                            onTap: () async {
                                              log("Like the song pressed");

                                              if (!isLiked) {
                                                await tracker.saveLikedSongs(
                                                  currentTrack,
                                                );
                                              } else {
                                                await tracker.removeLikedSong(
                                                  currentTrack.id,
                                                );
                                              }

                                              setState(() {});

                                              log(
                                                tracker
                                                    .likedSongs()
                                                    .length
                                                    .toString(),
                                              );
                                            },
                                            child: !isLiked
                                                ? const Icon(
                                                    Icons.add_circle_outline,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  )
                                                : const Icon(
                                                    Icons.check_circle,
                                                    color: Color.fromARGB(
                                                      255,
                                                      92,
                                                      214,
                                                      96,
                                                    ),
                                                    size: 20,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const Expanded(
                              child: Center(
                                child: Text(
                                  "No recent songs",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
