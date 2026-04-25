// ignore_for_file: comment_references

import 'package:flutter/material.dart';

/// A single item in a [CurvedNavigationBarPro].
///
/// ### Icon-only (existing usage — unchanged)
/// Pass [inactiveIcon] / [activeIcon] as before:
///
/// ```dart
/// const CurvedNavigationItemPro(
///   inactiveIcon: Icons.home_outlined,
///   activeIcon:   Icons.home_rounded,
///   label: 'Home',
/// )
/// ```
///
/// ### Custom widget (SVG, Lottie, Image …)
/// Supply [inactiveWidget] and/or [activeWidget] instead.
/// These take priority over the corresponding [IconData] fields:
///
/// ```dart
/// CurvedNavigationItemPro(
///   inactiveWidget: SvgPicture.asset('assets/home.svg', colorFilter: ...),
///   activeWidget:   SvgPicture.asset('assets/home_filled.svg'),
///   label: 'Home',
/// )
/// ```
///
/// You may also mix: supply a widget for one state and an icon for the other.
/// If neither a widget nor an icon is provided for the inactive state, an
/// empty [SizedBox] is rendered.
@immutable
class CurvedNavigationItemPro {
  /// Creates a navigation item.
  ///
  /// Either [inactiveIcon] or [inactiveWidget] must be provided (or both, in
  /// which case [inactiveWidget] takes priority).  Likewise for the active
  /// state: [activeWidget] > [activeIcon] > [inactiveWidget] > [inactiveIcon].
  const CurvedNavigationItemPro({
    this.inactiveIcon,
    this.activeIcon,
    this.inactiveWidget,
    this.activeWidget,
    required this.label,
  }) : assert(
          inactiveIcon != null || inactiveWidget != null,
          'Provide at least one of inactiveIcon or inactiveWidget.',
        );

  // ── IconData shortcuts ──────────────────────────────────────────────────────

  /// Icon shown in the bar when the item is **inactive**.
  ///
  /// Ignored when [inactiveWidget] is also supplied.
  final IconData? inactiveIcon;

  /// Icon shown inside the FAB bubble when this item is **active**.
  ///
  /// Falls back to [inactiveIcon] when omitted.
  /// Ignored when [activeWidget] is also supplied.
  final IconData? activeIcon;

  // ── Widget overrides ────────────────────────────────────────────────────────

  /// Arbitrary widget shown in the bar when the item is **inactive**
  /// (e.g. an `SvgPicture`, `Lottie`, or `Image`).
  ///
  /// Takes priority over [inactiveIcon].
  final Widget? inactiveWidget;

  /// Arbitrary widget shown inside the FAB bubble when this item is **active**.
  ///
  /// Takes priority over [activeIcon] (and [inactiveWidget] / [inactiveIcon]
  /// fallback chain).
  final Widget? activeWidget;

  // ── Label ───────────────────────────────────────────────────────────────────

  /// Short label drawn below the icon (or below the notch area when active).
  final String label;

  // ── Resolved widget helpers (used internally by the widget) ────────────────

  /// Returns the widget to display in the bar when this item is inactive.
  ///
  /// Resolution: [inactiveWidget] → `Icon(inactiveIcon)` → [SizedBox.shrink].
  Widget resolvedInactiveWidget({required Color color, required double size}) {
    if (inactiveWidget != null) return inactiveWidget!;
    if (inactiveIcon != null) return Icon(inactiveIcon, color: color, size: size);
    return const SizedBox.shrink();
  }

  /// Returns the widget to display inside the FAB bubble when this item is
  /// active.
  ///
  /// Resolution: [activeWidget] → [inactiveWidget] →
  ///   `Icon(activeIcon ?? inactiveIcon)` → [SizedBox.shrink].
  Widget resolvedActiveWidget({required Color color, required double size}) {
    if (activeWidget != null) return activeWidget!;
    if (inactiveWidget != null) return inactiveWidget!;
    final icon = activeIcon ?? inactiveIcon;
    if (icon != null) return Icon(icon, color: color, size: size);
    return const SizedBox.shrink();
  }
}
