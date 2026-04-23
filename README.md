# curved_navigation_bar_pro

[![pub version](https://img.shields.io/pub/v/curved_navigation_bar_pro.svg)](https://pub.dev/packages/curved_navigation_bar_pro)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.10%2B-blue?logo=flutter)](https://flutter.dev)
[![GitHub Sponsors](https://img.shields.io/github/sponsors/aslamambiloly?style=flat&logo=github&label=Sponsor&color=ea4aaa)](https://github.com/sponsors/aslamambiloly)

A beautiful Flutter bottom navigation bar with a **smooth animated curved notch**, an **elastic FAB bubble** that glides between items, and comprehensive theming support.

---

## Features

- 🎯 Animated notch that slides smoothly to the selected item
- 💫 Elastic pop-in animation for the FAB bubble
- 📐 Mathematically continuous C¹ shoulder curves (no kinks at the notch edges)
- 🎨 Full theming — colours, geometry, elevation, text styles
- ♿ Built-in accessibility semantics
- 🧩 2–6 navigation items
- 📦 Zero dependencies beyond Flutter

---

## Preview

<table>
  <tr>
    <td align="center"><b>Navigation</b></td>
    <td align="center"><b>Playground</b></td>
  </tr>
  <tr>
    <td>
      <img src="https://raw.githubusercontent.com/aslamambiloly/curved_navigation_bar_pro/main/doc/demo.gif" width="220"/>
    </td>
    <td>
      <img src="https://raw.githubusercontent.com/aslamambiloly/curved_navigation_bar_pro/main/doc/playground.gif" width="220"/>
    </td>
  </tr>
</table>

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  curved_navigation_bar_pro: ^1.0.2
```

Then run:

```bash
flutter pub get
```

---

## Quick start

```dart
import 'package:curved_navigation_bar_pro/curved_navigation_bar_pro.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ...,
      bottomNavigationBar: CurvedNavBar(
        items: const [
          CurvedNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: 'HOME',
          ),
          CurvedNavItem(icon: Icons.search_outlined, label: 'SEARCH'),
          CurvedNavItem(
            icon: Icons.favorite_outline,
            activeIcon: Icons.favorite_rounded,
            label: 'SAVED',
          ),
          CurvedNavItem(
            icon: Icons.person_outline_rounded,
            activeIcon: Icons.person_rounded,
            label: 'PROFILE',
          ),
        ],
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
```

---

## Customisation

```dart
CurvedNavBar(
  items: ...,
  currentIndex: _index,
  onTap: (i) => setState(() => _index = i),

  // Colours
  backgroundColor: Colors.white,
  activeColor: Colors.indigo,
  activeIconColor: Colors.white,
  inactiveColor: const Color(0xFFADB5BD),
  fabColor: Colors.indigo,

  // Geometry
  barHeight: 110,
  fabRadius: 28,
  fabGap: 10,
  fabSink: 22,
  notchShoulderRadius: 12,
  cornerRadius: 16,

  // Shadow
  elevation: 14,
  shadowColor: Colors.black26,

  // Animation
  animationDuration: const Duration(milliseconds: 400),
  animationCurve: Curves.easeInOutCubic,

  // Text styles (optional overrides)
  activeTextStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
  inactiveTextStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
)
```

---

## API Reference

### `CurvedNavBar`

| Property | Type | Default | Description |
|---|---|---|---|
| `items` | `List<CurvedNavItem>` | **required** | 2–6 navigation items |
| `onTap` | `ValueChanged<int>` | **required** | Callback when an item is tapped |
| `currentIndex` | `int` | `0` | Selected item index |
| `backgroundColor` | `Color` | `Colors.white` | Bar background |
| `activeColor` | `Color?` | theme primary | Active label & default FAB colour |
| `activeIconColor` | `Color?` | `Colors.white` | Icon colour inside the FAB bubble |
| `inactiveColor` | `Color` | `#ADB5BD` | Inactive icon & label colour |
| `fabColor` | `Color?` | `activeColor` | FAB bubble background |
| `barHeight` | `double` | `110` | Bar height in logical pixels |
| `fabRadius` | `double` | `24` | FAB bubble radius |
| `fabGap` | `double` | `10` | Gap between FAB and notch arc |
| `fabSink` | `double` | `22` | Pixels the FAB centre sinks below the bar top |
| `notchShoulderRadius` | `double` | `12` | Shoulder fillet radius (0 = sharp corners) |
| `cornerRadius` | `double` | `0` | Top-left / top-right bar corner radius |
| `elevation` | `double` | `14` | Shadow depth |
| `shadowColor` | `Color` | `rgba(0,0,0,0.16)` | Shadow colour |
| `animationDuration` | `Duration` | `400 ms` | Notch slide duration |
| `animationCurve` | `Curve` | `easeInOutCubic` | Notch slide curve |
| `activeTextStyle` | `TextStyle?` | — | Override active label style |
| `inactiveTextStyle` | `TextStyle?` | — | Override inactive label style |

### `CurvedNavItem`

| Property | Type | Description |
|---|---|---|
| `icon` | `IconData` | Icon shown when inactive |
| `activeIcon` | `IconData?` | Icon shown in the FAB when active (falls back to `icon`) |
| `label` | `String` | Label text beneath the icon |

---

## Running the example

```bash
cd example
flutter run
```

---

## Contributing

PRs and issues are welcome! Please open an issue first for significant changes.

---

## License

[MIT](LICENSE) © 2025 aslamambiloly
