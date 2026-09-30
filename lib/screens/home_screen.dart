import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sf/audis_api.dart';
import 'package:sf/providers/track_provider.dart';
import 'package:sf/track_model.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void display() async {
    AudisApi api = AudisApi();

    final l = await api.getTrendingTracks();

    for (var i in l) {
      print("Title: ${i.title}");
      print("isStreamable: ${i.isStreamable}");
      print("Artist: ${i.artist}");
      print("ID: ${i.id}");
      print("-------------");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    display();
  }

  @override
  Widget build(BuildContext context) {
    final tracker = context.watch<TrackProvider>();
    final secondElement = tracker.recentSongs()[1];
    final thirdElement = tracker.recentSongs()[2];
    final fourthElement = tracker.recentSongs()[3];
    final fifthElement = tracker.recentSongs()[4];
    final sixthElement = tracker.recentSongs()[5];
    List<Map> justBackIn = [
      secondElement,
      thirdElement,
      fourthElement,
      fifthElement,
      sixthElement,
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(16),
                        ),

                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        child: Center(
                          child: Text(
                            "All",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        child: Center(
                          child: Text(
                            "Music",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        child: Center(
                          child: Text(
                            "Podcasts",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 3.45,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(81, 157, 155, 155),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // child: Row(
                        //   children: [
                        //     Container(child: Text("Image")),
                        //     Text(
                        //       "Hello",
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ],
                        // ),
                        // child: ListTile(title: Container(child: Text("Image"),sub)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            Container(child: Text("Image")),
                            Text(
                              "Hello",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            Container(child: Text("Image")),
                            Text(
                              "Hello",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            Container(child: Text("Image")),
                            Text(
                              "Hello",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            Container(child: Text("Image")),
                            Text(
                              "Hello",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            Container(child: Text("Image")),
                            Text(
                              "Hello",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            Container(child: Text("Image")),
                            Text(
                              "Hello",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            Container(child: Text("Image")),
                            Text(
                              "Hello",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Just back in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 3.8,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: justBackIn.length,
                      itemBuilder: (context, index) {
                        Map<dynamic, dynamic> element = justBackIn[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              context.read<TrackProvider>().setSongAndPlay(
                                TrackModel(
                                  id: element['id'] ?? "",
                                  title: element['title'] ?? "",
                                  artist: element['artist'] ?? "",
                                  duration: element['duration'] ?? "",
                                  isStreamable: element['isStreamable'] ?? "",
                                  artwork: element['artwork'] ?? "",
                                  streamUrl: element['streamUrl'] ?? "",
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.transparent,
                              ),
                              height: MediaQuery.sizeOf(context).height / 3.8,
                              width: MediaQuery.sizeOf(context).width / 2.5,

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      8,
                                    ),
                                    child: Image.network(
                                      element['artwork'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Song",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    element['title'],
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     spacing: 13,
                  //     children: [
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: Colors.blue,
                  //         ),
                  //         height: MediaQuery.sizeOf(context).height / 3.8,
                  //         width: MediaQuery.sizeOf(context).width / 2.5,

                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 color: Colors.green,
                  //               ),
                  //               height: MediaQuery.sizeOf(context).height / 5,
                  //               width: MediaQuery.sizeOf(context).width / 2.5,

                  //               child: Text("Image"),
                  //             ),
                  //             Text("Name of song"),
                  //           ],
                  //         ),
                  //       ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: Colors.blue,
                  //         ),
                  //         height: MediaQuery.sizeOf(context).height / 3.8,
                  //         width: MediaQuery.sizeOf(context).width / 2.5,

                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 color: Colors.green,
                  //               ),
                  //               height: MediaQuery.sizeOf(context).height / 5,
                  //               width: MediaQuery.sizeOf(context).width / 2.5,

                  //               child: Text("Image"),
                  //             ),
                  //             Text("Name of song"),
                  //           ],
                  //         ),
                  //       ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: Colors.blue,
                  //         ),
                  //         height: MediaQuery.sizeOf(context).height / 3.8,
                  //         width: MediaQuery.sizeOf(context).width / 2.5,

                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 color: Colors.green,
                  //               ),
                  //               height: MediaQuery.sizeOf(context).height / 5,
                  //               width: MediaQuery.sizeOf(context).width / 2.5,

                  //               child: Text("Image"),
                  //             ),
                  //             Text("Name of song"),
                  //           ],
                  //         ),
                  //       ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: Colors.blue,
                  //         ),
                  //         height: MediaQuery.sizeOf(context).height / 3.8,
                  //         width: MediaQuery.sizeOf(context).width / 2.5,

                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 color: Colors.green,
                  //               ),
                  //               height: MediaQuery.sizeOf(context).height / 5,
                  //               width: MediaQuery.sizeOf(context).width / 2.5,

                  //               child: Text("Image"),
                  //             ),
                  //             Text("Name of song"),
                  //           ],
                  //         ),
                  //       ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: Colors.blue,
                  //         ),
                  //         height: MediaQuery.sizeOf(context).height / 3.8,
                  //         width: MediaQuery.sizeOf(context).width / 2.5,

                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 color: Colors.green,
                  //               ),
                  //               height: MediaQuery.sizeOf(context).height / 5,
                  //               width: MediaQuery.sizeOf(context).width / 2.5,

                  //               child: Text("Image"),
                  //             ),
                  //             Text("Name of song"),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 30),
                  Text(
                    "Recommended for today",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  FutureBuilder<List<TrackModel>>(
                    future: AudisApi().getTrendingTracks(),

                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return Text(
                          "Error: ${snapshot.error}",
                          style: const TextStyle(color: Colors.white),
                        );
                      }

                      final songs = snapshot.data!;

                      return SizedBox(
                        height: 210,

                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: songs.length,
                          itemBuilder: (context, index) {
                            final song = songs[index];

                            return Container(
                              height: 210,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.only(right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      song.artwork ?? "",
                                      fit: BoxFit.cover,
                                      height: 160,
                                      width: 150,
                                    ),
                                  ),
                                  Text(
                                    song.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    song.artist,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Text("Hello", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
