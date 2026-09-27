import 'package:flutter/material.dart';
import 'package:sf/audis_api.dart';
import 'package:sf/track_model.dart';

class RecentsScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<RecentsScreen> createState() => _RecentsScreenState();
}

class _RecentsScreenState extends State<RecentsScreen> {
  TextEditingController searchController = TextEditingController();
  List<TrackModel> searchResult = [];

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

      setState(() {
        isSearching = false;
        searchResult = results;
      });
      for (var i in searchResult) {
        print(i.title);
        print(i.artist);
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
            cursorColor: Colors.green,
            controller: searchController,
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
              searchSongs(value);
            },
          ),
        ),
      ),

      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
