# Glass Bottom Navigation Bar Example

A complete example demonstrating how to integrate and use the `glass_bottom_navigation_bar` package in your Flutter application

---

## Installation

Add the package to your project by running:

```bash
flutter pub add glass_bottom_navigation_bar
```

Or add it manually to your `pubspec.yaml` :

```yaml
dependencies:
  glass_bottom_navigation_bar: latest_version
```

Then run:

```bash
flutter pub get
```

---

## Usage

Replace your standard `BottomNavigationBar` with `GlassBottomNavigationBar` inside your `Scaffold`

> **Important**
>
> Make sure to set `extendBody: true` in your `Scaffold`. This allows the body content to extend underneath the navigation bar, making the glass blur effect visible.

```dart
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
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
      ),
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
      extendBody: true, // Required for the glass effect
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: Text(
          'Screen $_currentIndex',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
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
        items: const [
          BottomNavigationBarItemData(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItemData(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItemData(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
```

---

## Result

- ✅ Beautiful glassmorphism bottom navigation bar.
- ✅ Easy to integrate.
- ✅ Fully customizable.
- ✅ Works as a drop-in replacement for Flutter's standard `BottomNavigationBar`
