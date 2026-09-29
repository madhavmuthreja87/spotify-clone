import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sf/providers/track_provider.dart';
import 'package:sf/track_model.dart';

class LikedSongs extends StatefulWidget {
  const LikedSongs({super.key});

  @override
  State<LikedSongs> createState() => _LikedSongsState();
}

class _LikedSongsState extends State<LikedSongs> {
  @override
  Widget build(BuildContext context) {
    final tracker = context.read<TrackProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 62, 82, 171),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 62, 82, 171),
                      Color.fromARGB(255, 60, 73, 132),
                      Color.fromARGB(255, 52, 57, 78),
                      Colors.black,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(123, 33, 33, 33),
                                borderRadius: BorderRadius.circular(7),
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.search_outlined,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "Find in Liked Songs",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            height: 40,
                            width: 65,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(123, 33, 33, 33),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                "Sort",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                      Text(
                        "Liked Songs",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 21),
                      Text(
                        "${tracker.likedBox.length} songs",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.install_mobile,
                            color: Colors.grey,
                            size: 25,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.shuffle,
                                color: const Color.fromARGB(255, 36, 206, 41),
                                size: 40,
                              ),
                              Icon(
                                Icons.play_circle_filled_outlined,
                                color: const Color.fromARGB(255, 36, 206, 41),
                                size: 60,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              /////////////////
              const SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                    child: Center(
                      child: Text("Rap", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                    child: Center(
                      child: Text(
                        "Energetic",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                    child: Center(
                      child: Text(
                        "Fast",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                    child: Center(
                      child: Text(
                        "Beats",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: tracker.likedSongs().length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final likedSong = tracker.likedSongs()[index];
                  return GestureDetector(
                    onTap: () {
                      log("liked list tapped");
                      context.read<TrackProvider>().setSongAndPlay(
                        TrackModel(
                          id: likedSong['id'] ?? "",
                          title: likedSong['title'] ?? "",
                          artist: likedSong['artist'] ?? "",
                          duration: likedSong['duration'] ?? "",
                          isStreamable: likedSong['isStreamable'] ?? "",
                          artwork: likedSong['artwork'] ?? "",
                          streamUrl: likedSong['streamUrl'] ?? "",
                        ),
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        context.read<TrackProvider>().setSongAndPlay(
                          TrackModel(
                            id: likedSong['id'] ?? "",
                            title: likedSong['title'] ?? "",
                            artist: likedSong['artist'] ?? "",
                            duration: likedSong['duration'] ?? "",
                            isStreamable: likedSong['isStreamable'] ?? "",
                            artwork: likedSong['artwork'] ?? "",
                            streamUrl: likedSong['streamUrl'] ?? "",
                          ),
                        );
                      },
                      child: ListTile(
                        //   contentPadding: EdgeInsets.zero,
                        dense: true,

                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image.network(
                            likedSong['artwork'],
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        title: Text(
                          likedSong['title'],
                          maxLines: 1,

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          likedSong['artist'],
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: Icon(
                          Icons.more_vert,
                          size: 26,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
