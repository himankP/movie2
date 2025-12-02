import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie/Screen/Detail.dart';
import 'package:movie/Screen/Favourite.dart';
import 'package:movie/Screen/Homescreen.dart';
import 'package:movie/Screen/Search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this line
  await dotenv.load(fileName: ".env"); // Load environment variables
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      home: MainScreen(), // This should be your main screen with bottom navigation
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    Homescreen(),
    Detail(),
    Search(), // Fixed typo: Serarch -> Search
    Favourite(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        currentIndex: selectedIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.details), label: 'Detail'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourite'),
        ],
      ),
    );
  }
}
