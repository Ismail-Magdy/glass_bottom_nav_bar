# Glass Bottom Navigation Bar

A Beautiful, Modern, and Highly Customizable **Glassmorphism** Bottom Navigation Bar for Flutter Applications

---

## Features

- Modern **Glassmorphism** effect
- ✅ Highly customizable appearance
  - Blur intensity
  - Background color
  - Opacity
  - Border color & width
  - Border radius
- Lightweight and easy to use
- Drop-in replacement for Flutter's standard `BottomNavigationBar`
- Works seamlessly with modern Flutter applications

---

## 📦 Installation

Add the package to your `pubspec.yaml` :

```yaml
dependencies:
  glass_bottom_navigation_bar: ^0.0.1
```

Then run :

```bash
flutter pub get
```

---

## Import

```dart
import "package:glass_bottom_navigation_bar/glass_bottom_navigation_bar.dart";
```

---

## Usage

```dart
Scaffold(
  extendBody: true, // Required to show the glass effect over the body
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
```

---

## 📸 Preview

<p align="center">
  <img src="https://raw.githubusercontent.com/Ismail-Magdy/glass_bottom_nav_bar/master/screenshots/demo.gif" alt="Glass Bottom Navigation Bar Demo" width="350"/>
</p>

---

## Contributing

Contributions, issues, and feature requests are welcome !

If you have ideas to improve this package, feel free to open an issue or submit a pull request

---

## Issues & Feature Requests

Found a bug or have a feature request ?

Please open an issue on GitHub:

https://github.com/Ismail-Magdy/glass_bottom_nav_bar/issues

---

## Repository

GitHub Repository:

https://github.com/Ismail-Magdy/glass_bottom_nav_bar

If you find this package useful, consider giving it a ⭐ on GitHub.
