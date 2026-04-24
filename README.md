# curved_navigation_bar_pro

[![pub version](https://img.shields.io/pub/v/curved_navigation_bar_pro.svg)](https://pub.dev/packages/curved_navigation_bar_pro)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.10%2B-blue?logo=flutter)](https://flutter.dev)
[![GitHub Sponsors](https://img.shields.io/github/sponsors/aslamambiloly?style=flat&logo=github&label=Sponsor&color=ea4aaa)](https://github.com/sponsors/aslamambiloly)

A beautiful Flutter bottom navigation bar with a **smooth animated curved notch**, an **elastic FAB bubble** that glides between items, and comprehensive theming support.

---

## Features

- Animated notch that slides smoothly to the selected item
- Elastic pop-in animation for the FAB bubble
- Mathematically continuous C¹ shoulder curves (no kinks at the notch edges)
- **10 built-in style presets** — drop in a complete look with one parameter
- Full theming — colours, geometry, elevation, text styles
- Built-in accessibility semantics
- 2–6 navigation items
- Zero dependencies beyond Flutter

---

## Preview

<table>
  <tr>
    <td align="center"><b>Showcase</b></td>
    <td align="center"><b>Playground</b></td>
    <td align="center"><b>Showcase II</b></td>
  </tr>
  <tr>
    <td>
      <img src="https://raw.githubusercontent.com/aslamambiloly/curved_navigation_bar_pro/main/doc/showcase.gif" width="250"/>
    </td>
    <td>
      <img src="https://raw.githubusercontent.com/aslamambiloly/curved_navigation_bar_pro/main/doc/playground.gif" width="250"/>
    </td>
     <td>
      <img src="https://raw.githubusercontent.com/aslamambiloly/curved_navigation_bar_pro/main/doc/showcase2.gif" width="250"/>
    </td>
  </tr>
</table>

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  curved_navigation_bar_pro: ^1.0.9
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
      bottomNavigationBar: CurvedNavigationBarPro(
        items: const [
          CurvedNavigationItemPro(
            inactiveIcon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: 'HOME',
          ),
          CurvedNavigationItemPro(inactiveIcon: Icons.search_outlined, label: 'SEARCH'),
          CurvedNavigationItemPro(
            inactiveIcon: Icons.favorite_outline,
            activeIcon: Icons.favorite_rounded,
            label: 'SAVED',
          ),
          CurvedNavigationItemPro(
            inactiveIcon: Icons.person_outline_rounded,
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
CurvedNavigationBarPro(
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

## Built-in Style Presets

Choose from 10 ready-made styles with a single `navbarStyle` parameter.
Every individual parameter you pass **overrides** the preset value — so presets
are a starting point, not a constraint.

### Apply a preset

```dart
CurvedNavigationBarPro(
  items: myItems,
  onTap: (i) => setState(() => _index = i),
  currentIndex: _index,
  navbarStyle: CNBPStyles.goldenHour, // full Golden Hour theme in one line
)
```

### Apply a preset and override one value

```dart
CurvedNavigationBarPro(
  items: myItems,
  onTap: (i) => setState(() => _index = i),
  currentIndex: _index,
  navbarStyle: CNBPStyles.berryBlossom,
  fabRadius: 32,       // ← overrides only this; everything else stays preset
)
```

### Use preset data directly

```dart
// Read a preset's values for your own logic
final data = CNBPStyles.royalAmethyst.data;
print(data.activeColor); // Color(0xFFBE73FF)

// Or tweak a preset into a custom CNBPStyleData object
final myStyle = CNBPStyles.arcticFrost.data.copyWith(
  cornerRadius: 0,
  elevation: 16,
);
```

### Available presets

| `CNBPStyles.*` | Bar background | Accent colour | Highlights |
|---|---|---|---|
| `classicIndigo` | White | `#6C63FF` indigo | Default look, standard geometry |
| `deepSpaceDark` | `#1A1A2E` charcoal | `#00E5FF` cyan | Sharp notch, spaced-caps labels |
| `roundedCoral` | White | `#FF6B6B` coral | Pill corners (`cornerRadius: 28`), smooth shoulders |
| `minimalMono` | White | `#2D3748` slate | Fully sunk FAB, sharp notch, monochrome |
| `emeraldPill` | `#0F2D26` dark green | `#00C896` emerald | Large FAB, rounded corners, suits 5 items |
| `sunsetAmber` | White | `#FF9F43` amber | Travel theme, smooth shoulders, `easeInOutSine` |
| `royalAmethyst` | `#0E0829` deep navy | `#BE73FF` lavender | Large protruding FAB, suits 3 items, `easeOutBack` |
| `arcticFrost` | `#F0F4F8` steel grey | `#2B6CB0` steel blue | Fully sunk FAB, pill corners, light theme |
| `berryBlossom` | `#1C0A1C` dark purple | `#FF6AC1` hot pink | Ultra-smooth notch, suits 5 items, `elasticOut` |
| `goldenHour` | `#121008` ink black | `#FFD700` gold | Dark icon in FAB, finance theme, `easeInOutCubic` |

---

## API Reference

### `CurvedNavigationBarPro`

| Property | Type | Default | Description |
|---|---|---|---|
| `items` | `List<CurvedNavigationItemPro>` | **required** | 2–6 navigation items |
| `onTap` | `ValueChanged<int>` | **required** | Callback when an item is tapped |
| `currentIndex` | `int` | `0` | Selected item index |
| `navbarStyle` | `CNBPStyles?` | `null` | Built-in preset — supplies defaults for all visual params |
| `backgroundColor` | `Color?` | preset → `Colors.white` | Bar background |
| `activeColor` | `Color?` | preset → theme primary | Active label & default FAB colour |
| `activeIconColor` | `Color?` | preset → `Colors.white` | Icon colour inside the FAB bubble |
| `inactiveColor` | `Color?` | preset → `#ADB5BD` | Inactive icon & label colour |
| `fabColor` | `Color?` | preset → `activeColor` | FAB bubble background |
| `barHeight` | `double?` | preset → `110` | Bar height in logical pixels |
| `fabRadius` | `double?` | preset → `24` | FAB bubble radius |
| `fabGap` | `double?` | preset → `10` | Gap between FAB edge and notch arc |
| `fabSink` | `double?` | preset → `22` | Pixels the FAB centre sinks below the bar top |
| `notchShoulderRadius` | `double?` | preset → `12` | Shoulder fillet radius (0 = sharp corners) |
| `cornerRadius` | `double?` | preset → `0` | Top-left / top-right bar corner radius |
| `elevation` | `double?` | preset → `14` | Shadow depth |
| `shadowColor` | `Color?` | preset → `rgba(0,0,0,0.16)` | Shadow colour |
| `animationDuration` | `Duration?` | preset → `400 ms` | Notch slide duration |
| `animationCurve` | `Curve?` | preset → `easeInOutCubic` | Notch slide curve |
| `activeTextStyle` | `TextStyle?` | preset → built-in | Override active label style |
| `inactiveTextStyle` | `TextStyle?` | preset → built-in | Override inactive label style |

> **Resolution order:** explicit parameter → `navbarStyle` preset → hardcoded default

### `CurvedNavigationItemPro`

| Property | Type | Description |
|---|---|---|
| `inactiveIcon` | `IconData` | Icon shown when inactive |
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

[MIT](LICENSE) © 2026 aslamambiloly
