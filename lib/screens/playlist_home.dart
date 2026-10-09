import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator_plus/palette_generator_plus.dart';
import 'package:provider/provider.dart';
import 'package:sf/providers/track_provider.dart';
import 'package:sf/screens/add_to_playlist.dart';
import 'package:sf/models/track_model.dart';

class PlaylistHome extends StatefulWidget {
  final String pname;
  const PlaylistHome({super.key, required this.pname});

  @override
  State<PlaylistHome> createState() => _PlaylistHomeState();
}

class _PlaylistHomeState extends State<PlaylistHome> {
  @override
  Widget build(BuildContext context) {
    //final tracker = context.watch<TrackProvider>();
    //final songofplaylist = tracker.songsOfPlaylist(widget.pname);

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
                      const SizedBox(height: 35),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width / 1.7,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddToPlaylist(pname: widget.pname),
                                  ),
                                );
                              },
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

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 4,
                        ),
                        child: Consumer<TrackProvider>(
                          builder: (context, tracker, child) {
                            return ListView.builder(
                              itemCount: tracker
                                  .songsOfPlaylist(widget.pname)
                                  .length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final songinplaylist = tracker.songsOfPlaylist(
                                  widget.pname,
                                )[index];

                                final bool isinplaylist = tracker
                                    .songsOfPlaylist(widget.pname)
                                    .any(
                                      (song) =>
                                          song['id'] == songinplaylist['id'],
                                    );
                                final TrackModel currentTrack = TrackModel(
                                  id: songinplaylist['id'] ?? "",
                                  title: songinplaylist['title'] ?? "",
                                  artist: songinplaylist['artist'] ?? "",
                                  duration: songinplaylist['duration'] ?? "",
                                  isStreamable:
                                      songinplaylist['is_streamable'] ?? "",
                                  artwork: songinplaylist['artwork'] ?? "",
                                  streamUrl: songinplaylist['streamUrl'] ?? "",
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
                                      // child: Image.network(
                                      //   songinplaylist['artwork'],
                                      //   fit: BoxFit.cover,
                                      //   height: 47,
                                      //   width: 47,
                                      // ),
                                      child: CachedNetworkImage(
                                        imageUrl: songinplaylist['artwork'],
                                        fit: BoxFit.cover,
                                        height: 47,
                                        width: 47,
                                        errorWidget: (context, url, error) =>
                                            Container(
                                              color: const Color.fromARGB(
                                                225,
                                                160,
                                                160,
                                                160,
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.music_note,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                      ),
                                    ),

                                    title: Text(
                                      songinplaylist['title'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    subtitle: Text(
                                      songinplaylist['artist'],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),

                                    trailing: Icon(
                                      Icons.more_vert,
                                      color: const Color.fromARGB(
                                        255,
                                        118,
                                        117,
                                        117,
                                      ),
                                      size: 25,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
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
                      ///////////////////////////////////////////////////////////////////////////////////////////////////
                      Consumer<TrackProvider>(
                        builder: (context, tracker, child) {
                          return tracker.recentSongs().length > 4
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 0,
                                    bottom: 110,
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: tracker.recentSongs().length,
                                    itemBuilder: (context, index) {
                                      final recentContent = tracker
                                          .recentSongs()[index];

                                      final bool isinplaylist = tracker
                                          .songsOfPlaylist(widget.pname)
                                          .any(
                                            (song) =>
                                                song['id'] ==
                                                recentContent['id'],
                                          );

                                      TrackModel currentTrack = TrackModel(
                                        id: recentContent['id'] ?? "",
                                        title: recentContent['title'] ?? "",
                                        artist: recentContent['artist'] ?? "",
                                        duration:
                                            recentContent['duration'] ?? "",
                                        isStreamable:
                                            recentContent['is_streamable'] ??
                                            "",
                                        artwork: recentContent['artwork'] ?? "",
                                        streamUrl:
                                            recentContent['streamUrl'] ?? "",
                                      );

                                      return GestureDetector(
                                        onTap: () {
                                          context.read<TrackProvider>().setSongAndPlay(
                                            TrackModel(
                                              id: recentContent['id'] ?? "",
                                              title:
                                                  recentContent['title'] ?? "",
                                              artist:
                                                  recentContent['artist'] ?? "",
                                              duration:
                                                  recentContent['duration'] ??
                                                  "",
                                              isStreamable:
                                                  recentContent['isStreamable'] ??
                                                  "",
                                              artwork:
                                                  recentContent['artwork'] ??
                                                  "",
                                              streamUrl:
                                                  recentContent['streamUrl'] ??
                                                  "",
                                            ),
                                          );
                                        },
                                        child: !isinplaylist
                                            ? ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                dense: true,
                                                leading: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  // child: Image.network(
                                                  //   recentContent['artwork'],
                                                  //   fit: BoxFit.cover,
                                                  //   height: 47,
                                                  //   width: 47,
                                                  // ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        recentContent['artwork'],
                                                    fit: BoxFit.cover,
                                                    height: 47,
                                                    width: 47,
                                                    errorWidget:
                                                        (
                                                          context,
                                                          url,
                                                          error,
                                                        ) => Container(
                                                          color:
                                                              const Color.fromARGB(
                                                                225,
                                                                160,
                                                                160,
                                                                160,
                                                              ),
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.music_note,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
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
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const SizedBox(width: 8),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        if (!isinplaylist) {
                                                          await tracker
                                                              .addToPlaylist(
                                                                widget.pname,
                                                                currentTrack,
                                                              );
                                                          log(
                                                            "Add to   ${widget.pname}   playist",
                                                          );
                                                        } else {
                                                          await tracker
                                                              .removeFromPlaylist(
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
                                                              .songsOfPlaylist(
                                                                widget.pname,
                                                              )
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
                                                              Icons
                                                                  .add_circle_outline,
                                                              color:
                                                                  const Color.fromARGB(
                                                                    255,
                                                                    118,
                                                                    118,
                                                                    118,
                                                                  ),
                                                              size: 22,
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color:
                                                                  const Color.fromARGB(
                                                                    255,
                                                                    92,
                                                                    214,
                                                                    96,
                                                                  ),
                                                              size: 22,
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : const SizedBox(),
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
                                );
                        },
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
