/// A beautiful Flutter bottom navigation bar with an animated curved notch FAB,
/// smooth elastic bubble animation, and fully customisable theming.
///
/// ## Quick start
///
/// ```dart
/// import 'package:curved_nav_bar/curved_nav_bar.dart';
///
/// CurvedNavBar(
///   items: const [
///     CurvedNavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'HOME'),
///     CurvedNavItem(icon: Icons.search_outlined, label: 'SEARCH'),
///     CurvedNavItem(icon: Icons.favorite_outline, activeIcon: Icons.favorite, label: 'SAVED'),
///     CurvedNavItem(icon: Icons.person_outline, activeIcon: Icons.person, label: 'PROFILE'),
///   ],
///   currentIndex: _index,
///   onTap: (i) => setState(() => _index = i),
/// )
/// ```
library curved_nav_bar;

export 'src/curved_nav_bar.dart';
export 'src/curved_nav_item.dart';
