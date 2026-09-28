import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sf/audis_api.dart';

import 'package:sf/providers/track_provider.dart';
import 'package:sf/track_model.dart';

class RecentsScreen extends StatefulWidget {
  const RecentsScreen({super.key});

  @override
  State<RecentsScreen> createState() => _RecentsScreenState();
}

class _RecentsScreenState extends State<RecentsScreen> {
  TextEditingController searchController = TextEditingController();
  List<TrackModel> searchResult = [];
  List<TrackModel> recentResult = [];

  bool isSearching = false;

  Future<void> searchSongs(String query) async {
    if (query.trim().isEmpty) {
      return;
    }

    setState(() {
      isSearching = true;
    });

    try {
      final results = await AudisApi().searchTracks(query);

      // final streamableResults = results
      //     .where((song) => song.isStreamable)
      //     .toList();

      setState(() {
        isSearching = false;
        searchResult = results;
      });

      for (var i in searchResult) {
        print("Title: ${i.title}");
        print("isStreamable: ${i.isStreamable}");
        print("Artist: ${i.artist}");
        print("ID: ${i.id}");
        print("-------------");
      }
    } catch (e) {
      setState(() {
        isSearching = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final player = context.watch<TrackProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        titleSpacing: 0,
        backgroundColor: Colors.black,
        title: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 44,
          child: TextField(
            controller: searchController,
            cursorColor: Colors.green,
            autofocus: true,
            selectionControls: EmptyTextSelectionControls(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),

              filled: true,
              hint: Text(
                "What do you want to listen to?",
                style: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 224, 224, 224),
                  fontWeight: FontWeight.w600,
                ),
              ),
              fillColor: const Color.fromARGB(255, 106, 105, 105),
            ),
            onSubmitted: (value) {
              // if (value.isEmpty) {
              //   setState(() {
              //     searchResult = [];
              //   });
              //   return;
              // }

              searchSongs(value);
            },
          ),
        ),
      ),

      body: SafeArea(
        child: searchResult.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: searchResult.length,
                itemBuilder: (context, index) {
                  final searchContent = searchResult[index];

                  return GestureDetector(
                    onTap: () {
                      log("music list tapped");
                      context.read<TrackProvider>().setSongAndPlay(
                        searchContent,
                      );
                    },
                    child: ListTile(
                      //   contentPadding: EdgeInsets.zero,
                      dense: true,

                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.network(
                          searchContent.artwork!,
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      title: Text(
                        searchContent.title,
                        maxLines: 1,

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        searchContent.artist,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                },
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        log("Recent songs :${recentResult.length}");
                        for (TrackModel i in recentResult) {
                          log(i.title);
                          log(i.id);
                          log("----------");
                        }
                      },
                      child: Text(
                        "Recents",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: player.recentSongs().length,
                        itemBuilder: (context, index) {
                          final recentContent = player.recentSongs()[index];

                          return GestureDetector(
                            onTap: () {
                              context.read<TrackProvider>().setSongAndPlay(
                                TrackModel(
                                  id: recentContent['id'] ?? "",
                                  title: recentContent['title'] ?? "",
                                  artist: recentContent['artist'] ?? "",
                                  duration: recentContent['duration'] ?? "",
                                  isStreamable:
                                      recentContent['isStreamable'] ?? "",
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
                                child: Image.network(
                                  recentContent['artwork'],
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              title: Text(
                                recentContent['title'],
                                maxLines: 1,

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                recentContent['artist'],
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
