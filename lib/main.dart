import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:sf/providers/track_provider.dart';
import 'package:sf/screens/home_screen.dart';
import 'package:sf/screens/library_screen.dart';
import 'package:sf/screens/search_screen.dart';
import 'package:sf/screens/settings_screen.dart';
import 'package:sf/widgets/mini_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox("recentSongs");
  await Hive.openBox('likedSongs');

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
  List<Widget> screen = const [
    HomeScreen(),
    SearchScreen(),
    LibraryScreen(),
    SettingsScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final player = context.watch<TrackProvider>();
    return Scaffold(
      body: Navigator(
        key: navigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (_) => screen[currentIndex]);
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (player.currentSong != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Material(
                child: MiniPlayer(
                  song: player.currentSong!,

                  onPlayPause: () {
                    if (player.isPlaying) {
                      player.pause();
                    } else
                      player.resume();
                  },
                  onTap: () {},
                ),
              ),
            ),
          BottomNavigationBar(
            type: BottomNavigationBarType.shifting,

            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,

            currentIndex: currentIndex,

            onTap: (value) {
              setState(() {
                currentIndex = value;
              });

              navigatorKey.currentState!.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => screen[value]),
                (route) => false,
              );
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "Home",
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded),
                label: "Search",
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                label: "Library",
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
                backgroundColor: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
