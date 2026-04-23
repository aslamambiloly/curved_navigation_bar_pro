import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'curved_navigation_item_pro.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  Public widget
// ─────────────────────────────────────────────────────────────────────────────

/// A bottom navigation bar with a smooth animated curved notch and an elastic
/// FAB bubble that slides to the selected item.
///
/// ## Basic usage
/// ```dart
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
///
/// Place the widget in [Scaffold.bottomNavigationBar]:
/// ```dart
/// Scaffold(
///   bottomNavigationBar: CurvedNavBar(...),
///   body: ...,
/// )
/// ```
class CurvedNavBarPro extends StatefulWidget {
  /// Creates a [CurvedNavBarPro].
  ///
  /// [items] must contain between 2 and 6 entries (inclusive).
  const CurvedNavBarPro({
    super.key,
    required this.items,
    required this.onTap,
    this.currentIndex = 0,
    this.backgroundColor = Colors.white,
    this.activeColor,
    this.activeIconColor,
    this.inactiveColor = const Color(0xFFADB5BD),
    this.fabColor,
    this.barHeight = 110.0,
    this.fabRadius = 24.0,
    this.fabGap = 10.0,
    this.fabSink = 22.0,
    this.notchShoulderRadius = 12.0,
    this.cornerRadius = 0.0,
    this.elevation = 14.0,
    this.shadowColor = const Color(0x2A000000),
    this.animationDuration = const Duration(milliseconds: 400),
    this.animationCurve = Curves.easeInOutCubic,
    this.activeTextStyle,
    this.inactiveTextStyle,
  })  : assert(
          items.length >= 2 && items.length <= 6,
          'CurvedNavBar requires between 2 and 6 items, '
          'but ${items.length} were provided.',
        ),
        assert(
          currentIndex >= 0 && currentIndex < items.length,
          'currentIndex ($currentIndex) must be in range [0, ${items.length}).',
        );

  // ── Content ─────────────────────────────────────────────────────────────────

  /// The navigation items (2–6).
  final List<CurvedNavItemPro> items;

  /// Called when the user taps a navigation item; receives the tapped index.
  final ValueChanged<int> onTap;

  /// Index of the currently selected item (0-based). Defaults to `0`.
  final int currentIndex;

  // ── Colours ──────────────────────────────────────────────────────────────────

  /// Background colour of the bar. Defaults to [Colors.white].
  final Color backgroundColor;

  /// Colour for active label text.
  ///
  /// Defaults to [ColorScheme.primary] from the nearest [Theme].
  final Color? activeColor;

  /// Icon colour inside the FAB bubble. Defaults to [Colors.white].
  final Color? activeIconColor;

  /// Icon and label colour for inactive items. Defaults to `#ADB5BD`.
  final Color inactiveColor;

  /// Background colour of the FAB bubble. Defaults to [activeColor].
  final Color? fabColor;

  // ── Geometry ─────────────────────────────────────────────────────────────────

  /// Total pixel height of the bar (not counting any FAB protrusion).
  /// Defaults to `110`.
  final double barHeight;

  /// Radius of the FAB bubble in logical pixels. Defaults to `24`.
  final double fabRadius;

  /// Extra spacing between the FAB edge and the notch arc. Defaults to `10`.
  final double fabGap;

  /// How many pixels the FAB centre sinks **below** the bar's top edge.
  ///
  /// - `0`: centre is at the bar's top (half protruding, half inside).
  /// - `fabRadius`: FAB is fully inside; its top edge is flush with the bar top.
  ///
  /// Defaults to `22`.
  final double fabSink;

  /// Radius of the smooth C¹-continuous shoulder curves that transition the
  /// flat bar surface into the notch arc. `0` gives sharp corners.
  /// Defaults to `12`.
  final double notchShoulderRadius;

  /// Radius of the top-left and top-right corners of the bar. Defaults to `0`.
  final double cornerRadius;

  // ── Shadow ───────────────────────────────────────────────────────────────────

  /// Elevation used to compute the bar's drop-shadow depth. Defaults to `14`.
  final double elevation;

  /// Shadow colour. Defaults to `rgba(0,0,0,0.16)`.
  final Color shadowColor;

  // ── Animation ────────────────────────────────────────────────────────────────

  /// Duration of the notch slide animation. Defaults to `400 ms`.
  final Duration animationDuration;

  /// Easing curve for the notch slide. Defaults to [Curves.easeInOutCubic].
  final Curve animationCurve;

  // ── Text styles ───────────────────────────────────────────────────────────────

  /// Custom text style for the active label. Overrides the built-in default.
  final TextStyle? activeTextStyle;

  /// Custom text style for inactive labels. Overrides the built-in default.
  final TextStyle? inactiveTextStyle;

  @override
  State<CurvedNavBarPro> createState() => _CurvedNavBarProState();
}

// ─────────────────────────────────────────────────────────────────────────────
//  State
// ─────────────────────────────────────────────────────────────────────────────
class _CurvedNavBarProState extends State<CurvedNavBarPro>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _fromFraction;
  late double _toFraction;

  double _indexToFraction(int index) =>
      widget.items.length == 1 ? 0.5 : index / (widget.items.length - 1);

  double get _liveFraction {
    final t = widget.animationCurve.transform(
      _controller.value.clamp(0.0, 1.0),
    );
    return _fromFraction + (_toFraction - _fromFraction) * t;
  }

  @override
  void initState() {
    super.initState();
    _fromFraction = _indexToFraction(widget.currentIndex);
    _toFraction = _fromFraction;
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )
      ..addListener(() => setState(() {}))
      ..value = 1.0;
  }

  @override
  void didUpdateWidget(CurvedNavBarPro old) {
    super.didUpdateWidget(old);
    if (old.currentIndex != widget.currentIndex) {
      _fromFraction = _liveFraction;
      _toFraction = _indexToFraction(widget.currentIndex);
      _controller
        ..value = 0.0
        ..forward();
    }
    // Sync duration changes without rebuilding the controller.
    if (old.animationDuration != widget.animationDuration) {
      _controller.duration = widget.animationDuration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = widget.activeColor ?? theme.colorScheme.primary;
    final fabColor = widget.fabColor ?? activeColor;
    final fraction = _liveFraction;

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final itemWidth = totalWidth / widget.items.length;
        final notchR = widget.fabRadius + widget.fabGap;
        final sink = widget.fabSink.clamp(0.0, widget.fabRadius);
        final protrude = widget.fabRadius - sink;

        final rawCX =
            fraction * (widget.items.length - 1) * itemWidth + itemWidth / 2;
        final bubbleCX = rawCX.clamp(
          widget.fabRadius.toDouble(),
          totalWidth - widget.fabRadius,
        );

        final activeItem = widget.items[widget.currentIndex];
        final fabIcon = activeItem.activeIcon ?? activeItem.icon;

        return Semantics(
          container: true,
          explicitChildNodes: true,
          child: SizedBox(
            width: totalWidth,
            height: widget.barHeight + protrude,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // ── Bar ──────────────────────────────────────────────────────
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: widget.barHeight,
                  child: CustomPaint(
                    painter: _SemicircleNotchPainter(
                      notchCX: bubbleCX,
                      notchR: notchR,
                      fabSink: sink,
                      notchShoulderRadius: widget.notchShoulderRadius,
                      cornerRadius: widget.cornerRadius,
                      color: widget.backgroundColor,
                      shadowColor: widget.shadowColor,
                      elevation: widget.elevation,
                    ),
                  ),
                ),

                // ── Nav items ────────────────────────────────────────────────
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: widget.barHeight,
                  child: Row(
                    children: List.generate(widget.items.length, (i) {
                      return Expanded(
                        child: _NavItemTile(
                          item: widget.items[i],
                          index: i,
                          isActive: i == widget.currentIndex,
                          activeColor: activeColor,
                          inactiveColor: widget.inactiveColor,
                          animationDuration: widget.animationDuration,
                          activeTextStyle: widget.activeTextStyle,
                          inactiveTextStyle: widget.inactiveTextStyle,
                          onTap: () => widget.onTap(i),
                        ),
                      );
                    }),
                  ),
                ),

                // ── FAB bubble ───────────────────────────────────────────────
                Positioned(
                  left: bubbleCX - widget.fabRadius,
                  top: 0,
                  child: _Bubble(
                    key: ValueKey(widget.currentIndex),
                    icon: fabIcon,
                    radius: widget.fabRadius,
                    activeIconColor: widget.activeIconColor,
                    color: fabColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Painter
// ─────────────────────────────────────────────────────────────────────────────

class _SemicircleNotchPainter extends CustomPainter {
  const _SemicircleNotchPainter({
    required this.notchCX,
    required this.notchR,
    required this.fabSink,
    required this.notchShoulderRadius,
    required this.cornerRadius,
    required this.color,
    required this.shadowColor,
    required this.elevation,
  });

  final double notchCX;
  final double notchR;
  final double fabSink;
  final double notchShoulderRadius;
  final double cornerRadius;
  final Color color;
  final Color shadowColor;
  final double elevation;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final S = notchShoulderRadius;

    if (S <= 0.1) {
      // Sharp corners fallback
      final halfChord = math.sqrt(
        math.max(0.0, notchR * notchR - fabSink * fabSink),
      );
      final leftEdge = notchCX - halfChord;
      final rightEdge = notchCX + halfChord;

      path.moveTo(0, cornerRadius);
      path.quadraticBezierTo(0, 0, cornerRadius, 0);
      path.lineTo(leftEdge, 0);
      path.arcToPoint(
        Offset(rightEdge, 0),
        radius: Radius.circular(notchR),
        clockwise: false,
        largeArc: fabSink > 0,
      );
      path.lineTo(size.width - cornerRadius, 0);
      path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);
    } else {
      // C¹-tangent shoulder paths
      final distSq =
          math.pow(S + notchR, 2) - math.pow(fabSink - S, 2) as double;
      final dx = math.sqrt(math.max(0.0, distSq));

      final xsLeft = notchCX - dx;
      final xsRight = notchCX + dx;
      final leftCenter = Offset(xsLeft, S);
      final cn = Offset(notchCX, fabSink);
      final dist = S + notchR;
      final ratio = S / dist;

      final p1Left = Offset(xsLeft, 0);
      final p2Left = Offset(
        leftCenter.dx + (cn.dx - leftCenter.dx) * ratio,
        leftCenter.dy + (cn.dy - leftCenter.dy) * ratio,
      );

      final rightCenter = Offset(xsRight, S);
      final p1Right = Offset(xsRight, 0);
      final p2Right = Offset(
        rightCenter.dx + (cn.dx - rightCenter.dx) * ratio,
        rightCenter.dy + (cn.dy - rightCenter.dy) * ratio,
      );

      if (xsLeft > cornerRadius) {
        path.moveTo(0, cornerRadius);
        path.quadraticBezierTo(0, 0, cornerRadius, 0);
        path.lineTo(p1Left.dx, 0);
      } else {
        path.moveTo(p1Left.dx, 0);
      }

      path.arcToPoint(p2Left, radius: Radius.circular(S), clockwise: true);
      path.arcToPoint(
        p2Right,
        radius: Radius.circular(notchR),
        clockwise: false,
        largeArc: S < fabSink,
      );
      path.arcToPoint(p1Right, radius: Radius.circular(S), clockwise: true);

      if (xsRight < size.width - cornerRadius) {
        path.lineTo(size.width - cornerRadius, 0);
        path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);
      } else {
        path.lineTo(size.width, p1Right.dy);
      }
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    if (elevation > 0) {
      canvas.drawPath(
        path.shift(Offset(0, -elevation * 0.15)),
        Paint()
          ..color = shadowColor
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, elevation * 0.6),
      );
    }

    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_SemicircleNotchPainter old) =>
      old.notchCX != notchCX ||
      old.notchR != notchR ||
      old.fabSink != fabSink ||
      old.notchShoulderRadius != notchShoulderRadius ||
      old.cornerRadius != cornerRadius ||
      old.color != color ||
      old.shadowColor != shadowColor ||
      old.elevation != elevation;
}

// ─────────────────────────────────────────────────────────────────────────────
//  Nav item tile
// ─────────────────────────────────────────────────────────────────────────────
class _NavItemTile extends StatelessWidget {
  const _NavItemTile({
    required this.item,
    required this.index,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.animationDuration,
    required this.onTap,
    this.activeTextStyle,
    this.inactiveTextStyle,
  });

  final CurvedNavItemPro item;
  final int index;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final Duration animationDuration;
  final TextStyle? activeTextStyle, inactiveTextStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: item.label,
      selected: isActive,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: isActive ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 100),
              child: Icon(item.icon, size: 22, color: inactiveColor),
            ),
            const SizedBox(height: 10),
            AnimatedDefaultTextStyle(
              duration: animationDuration,
              style: isActive
                  ? activeTextStyle ??
                      TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.9,
                        color: activeColor,
                      )
                  : inactiveTextStyle ??
                      TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                        color: inactiveColor,
                      ),
              child: Text(item.label),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Bubble  –  elastic pop-in on each new selection
// ─────────────────────────────────────────────────────────────────────────────
class _Bubble extends StatefulWidget {
  const _Bubble({
    super.key,
    required this.icon,
    required this.radius,
    required this.color,
    this.activeIconColor,
  });

  final IconData icon;
  final double radius;
  final Color color;
  final Color? activeIconColor;

  @override
  State<_Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<_Bubble> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _scale = Tween<double>(begin: 0.55, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (_, child) => Transform.scale(scale: _scale.value, child: child),
      child: Container(
        width: widget.radius * 2,
        height: widget.radius * 2,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
        child: Icon(
          widget.icon,
          color: widget.activeIconColor ?? Colors.white,
          size: widget.radius * 0.92,
        ),
      ),
    );
  }
}
