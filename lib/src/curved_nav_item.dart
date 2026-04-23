import 'package:flutter/material.dart';

/// A single item in a [CurvedNavBar].
///
/// Each item has a required [icon] and [label]. An optional [activeIcon] is
/// shown inside the animated FAB bubble when that tab is selected.
///
/// ```dart
/// const CurvedNavItem(
///   icon: Icons.home_outlined,
///   activeIcon: Icons.home,
///   label: 'HOME',
/// )
/// ```
@immutable
class CurvedNavItem {
  /// Creates a navigation item.
  const CurvedNavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });

  /// Icon shown in the bar when the item is **inactive**.
  final IconData icon;

  /// Icon shown inside the FAB bubble when this item is **active**.
  ///
  /// Defaults to [icon] when omitted.
  final IconData? activeIcon;

  /// Short label drawn below the icon (or below the notch area when active).
  final String label;
}
