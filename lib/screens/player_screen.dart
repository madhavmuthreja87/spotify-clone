import 'package:flutter/material.dart';
import 'package:sf/track_model.dart';

class PlayerScreen extends StatefulWidget {
  final TrackModel song;
  const PlayerScreen({super.key, required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.song.artwork!,
                      fit: BoxFit.cover,
                      height: 300,
                      width: 400,
                    ),
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
