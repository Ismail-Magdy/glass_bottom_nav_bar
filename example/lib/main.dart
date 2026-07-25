import 'package:flutter/material.dart';
import 'package:glass_bottom_navigation_bar/glass_bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Glass Bottom Navigation Bar Example",
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey[900]),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text(
          "Glass Bottom Nav Bar",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          "Screen $_currentIndex",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: GlassBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItemData(
            icon: const Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItemData(
            icon: const Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItemData(
            icon: const Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
