import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:sf/providers/track_provider.dart';
import 'package:sf/screens/home_screen.dart';
import 'package:sf/screens/library_screen.dart';
import 'package:sf/screens/playlist_home.dart';
import 'package:sf/screens/search_screen.dart';
import 'package:sf/screens/settings_screen.dart';
import 'package:sf/widgets/mini_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox("recentSongs");
  await Hive.openBox('likedSongs');
  await Hive.openBox("playlistBox");

  runApp(
    ChangeNotifierProvider(create: (_) => TrackProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NavigationBar());
  }
}

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => _MyAppState();
}

class _MyAppState extends State<NavigationBar> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final List<Widget> screen = const [
    HomeScreen(),
    SearchScreen(),
    LibraryScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    final player = context.watch<TrackProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          // SCREEN
          Navigator(
            key: navigatorKey,
            onGenerateRoute: (settings) {
              return MaterialPageRoute(builder: (_) => screen[currentIndex]);
            },
          ),

          // GRADIENT ONLY
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 250,
            child: IgnorePointer(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color.fromARGB(120, 0, 0, 0),
                      Color.fromARGB(220, 0, 0, 0),
                      Colors.black,
                    ],
                    stops: [0.0, 0.45, 0.75, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // CONTROLS
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (player.currentSong != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: MiniPlayer(
                      song: player.currentSong!,
                      onPlayPause: () {
                        if (player.isPlaying) {
                          player.pause();
                        } else {
                          player.resume();
                        }
                      },
                      onTap: () {},
                    ),
                  ),

                BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: const Color.fromARGB(255, 138, 138, 138),
                  currentIndex: currentIndex,
                  selectedFontSize: 11,
                  unselectedFontSize: 10,

                  onTap: (value) {
                    setState(() {
                      currentIndex = value;
                    });

                    navigatorKey.currentState!.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => screen[value]),
                      (route) => false,
                    );
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search_rounded),
                      label: "Search",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.library_books),
                      label: "Library",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: "Settings",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
