import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sf/providers/track_provider.dart';
import 'package:sf/screens/playlist_home.dart';

class CreatePlaylist extends StatefulWidget {
  const new({super.key});

  @override
  State<CreatePlaylist> createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  TextEditingController playlistnamecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final tracker = context.read<TrackProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color.fromARGB(255, 122, 122, 122), Colors.black],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Give your playlist a name",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    textAlign: TextAlign.center,
                    controller: playlistnamecontroller,
                    cursorColor: Colors.green,
                    cursorHeight: 40,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 35,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "My PlayList #1",
                      hintStyle: TextStyle(
                        fontSize: 30,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey, indent: 30, endIndent: 30),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 45,
                        width: 90,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: const BorderSide(color: Colors.grey),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      SizedBox(
                        height: 45,
                        width: 90,
                        child: TextButton(
                          onPressed: () async {
                            log("Create playlist tapped");
                            await tracker.createPlaylist(
                              playlistnamecontroller.text,
                            );
                            log(tracker.allplaylistsName().length.toString());
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(
                                  milliseconds: 800,
                                ),
                                reverseTransitionDuration: Duration.zero,
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                      return PlaylistHome(
                                        pname: playlistnamecontroller.text,
                                      );
                                    },
                                transitionsBuilder:
                                    (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      final tween =
                                          Tween<Offset>(
                                            begin: const Offset(0, -1),
                                            end: Offset.zero,
                                          ).chain(
                                            CurveTween(
                                              curve: Curves.easeOutCubic,
                                            ),
                                          );

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                              ),
                            );
                          },
                          child: Text(
                            "Create",
                            style: TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
