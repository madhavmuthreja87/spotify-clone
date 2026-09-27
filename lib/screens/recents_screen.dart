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

            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                final searchContent = searchResult[index];

                return ListTile(
                  dense: true,
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 50,
                    width: 50,
                    child: Image.network(
                      searchContent.artwork!,
                      fit: BoxFit.cover,
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
                  subtitle: Text(searchContent.artist, style: TextStyle()),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
