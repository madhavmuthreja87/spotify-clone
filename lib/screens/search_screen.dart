import 'package:flutter/material.dart';
import 'package:sf/audis_api.dart';
import 'package:sf/track_model.dart';

class SearchScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Text("M"),
                        backgroundColor: Colors.orange,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Search",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            Icon(
                              Icons.camera_enhance_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      hint: Text(
                        "What do you want to listen to?",

                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 109, 109, 109),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    onSubmitted: (value) {
                      searchSongs(value);
                    },
                  ),
                  const SizedBox(height: 30),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,

                    crossAxisCount: 2,
                    childAspectRatio: 2.6,
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.pink,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            left: 4,
                            child: Text(
                              "Music",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(255, 103, 187, 106),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            left: 4,
                            child: Text(
                              "Podcasts",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(255, 207, 105, 224),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            left: 4,
                            child: Text(
                              "Live\nEvents",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(255, 33, 91, 191),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            left: 4,
                            child: Text(
                              "Home of\nI-Pop",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Discover something new",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 13,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          height: MediaQuery.sizeOf(context).height / 3.8,
                          width: MediaQuery.sizeOf(context).width / 2.5,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                height: MediaQuery.sizeOf(context).height / 5,
                                width: MediaQuery.sizeOf(context).width / 2.5,

                                child: Text("Image"),
                              ),
                              Text("Name of song"),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          height: MediaQuery.sizeOf(context).height / 3.8,
                          width: MediaQuery.sizeOf(context).width / 2.5,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                height: MediaQuery.sizeOf(context).height / 5,
                                width: MediaQuery.sizeOf(context).width / 2.5,

                                child: Text("Image"),
                              ),
                              Text("Name of song"),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          height: MediaQuery.sizeOf(context).height / 3.8,
                          width: MediaQuery.sizeOf(context).width / 2.5,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                height: MediaQuery.sizeOf(context).height / 5,
                                width: MediaQuery.sizeOf(context).width / 2.5,

                                child: Text("Image"),
                              ),
                              Text("Name of song"),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          height: MediaQuery.sizeOf(context).height / 3.8,
                          width: MediaQuery.sizeOf(context).width / 2.5,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                height: MediaQuery.sizeOf(context).height / 5,
                                width: MediaQuery.sizeOf(context).width / 2.5,

                                child: Text("Image"),
                              ),
                              Text("Name of song"),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          height: MediaQuery.sizeOf(context).height / 3.8,
                          width: MediaQuery.sizeOf(context).width / 2.5,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                height: MediaQuery.sizeOf(context).height / 5,
                                width: MediaQuery.sizeOf(context).width / 2.5,

                                child: Text("Image"),
                              ),
                              Text("Name of song"),
                            ],
                          ),
                        ),
                      ],
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
