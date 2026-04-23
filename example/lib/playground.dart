import 'package:curved_navigation_bar_pro/curved_navigation_bar_pro.dart';
import 'package:flutter/material.dart';

void main() => runApp(const PlaygroundApp());

class PlaygroundApp extends StatelessWidget {
  const PlaygroundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CurvedNavBar Playground',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF6C63FF),
        useMaterial3: true,
        fontFamily: 'packages/curved_navigation_bar_pro/sora',
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color(0xFF6C63FF),
        brightness: Brightness.light,
        useMaterial3: true,
        fontFamily: 'packages/curved_navigation_bar_pro/sora',
      ),
      themeMode: ThemeMode.light,
      home: const PlaygroundPage(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  All tunable parameters in one immutable value object
// ─────────────────────────────────────────────────────────────────────────────
class _Params {
  const _Params({
    this.barHeight = 110,
    this.fabRadius = 24,
    this.fabGap = 10,
    this.fabSink = 22,
    this.notchShoulderRadius = 12,
    this.cornerRadius = 0,
    this.elevation = 14,
    this.animDurationMs = 400,
    this.activeColor = const Color(0xFF6C63FF),
    this.backgroundColor = Colors.white,
    this.itemCount = 4,
    this.darkBar = false,
  });

  final double barHeight;
  final double fabRadius;
  final double fabGap;
  final double fabSink;
  final double notchShoulderRadius;
  final double cornerRadius;
  final double elevation;
  final double animDurationMs;
  final Color activeColor;
  final Color backgroundColor;
  final int itemCount;
  final bool darkBar;

  _Params copyWith({
    double? barHeight,
    double? fabRadius,
    double? fabGap,
    double? fabSink,
    double? notchShoulderRadius,
    double? cornerRadius,
    double? elevation,
    double? animDurationMs,
    Color? activeColor,
    Color? backgroundColor,
    int? itemCount,
    bool? darkBar,
  }) =>
      _Params(
        barHeight: barHeight ?? this.barHeight,
        fabRadius: fabRadius ?? this.fabRadius,
        fabGap: fabGap ?? this.fabGap,
        fabSink: fabSink ?? this.fabSink,
        notchShoulderRadius: notchShoulderRadius ?? this.notchShoulderRadius,
        cornerRadius: cornerRadius ?? this.cornerRadius,
        elevation: elevation ?? this.elevation,
        animDurationMs: animDurationMs ?? this.animDurationMs,
        activeColor: activeColor ?? this.activeColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        itemCount: itemCount ?? this.itemCount,
        darkBar: darkBar ?? this.darkBar,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  Playground page
// ─────────────────────────────────────────────────────────────────────────────
class PlaygroundPage extends StatefulWidget {
  const PlaygroundPage({super.key});

  @override
  State<PlaygroundPage> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  _Params _p = const _Params();
  int _navIndex = 0;

  // Palette options for activeColor picker
  static const _palette = [
    Color(0xFF6C63FF),
    Color(0xFFFF6584),
    Color(0xFF43D9AD),
    Color(0xFFFF9500),
    Color(0xFF0A84FF),
    Color(0xFFFF453A),
    Color(0xFF30D158),
    Color(0xFFFFD60A),
  ];

  // Bar background options
  static const _bgOptions = [
    Colors.white,
    Color(0xFF1C1C1E),
    Color(0xFFF5F0FF),
    Color(0xFFE8F5E9),
    Color(0xFFFFF3E0),
  ];
  static const _bgLabels = ['White', 'Dark', 'Lavender', 'Mint', 'Peach'];

  static const _allItems = [
    CurvedNavigationItemPro(
        icon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
        label: 'Home'),
    CurvedNavigationItemPro(
        icon: Icons.search_outlined,
        activeIcon: Icons.search_rounded,
        label: 'Search'),
    CurvedNavigationItemPro(
        icon: Icons.favorite_outline,
        activeIcon: Icons.favorite_rounded,
        label: 'Saved'),
    CurvedNavigationItemPro(
        icon: Icons.person_outline_rounded,
        activeIcon: Icons.person_rounded,
        label: 'Profile'),
    CurvedNavigationItemPro(
        icon: Icons.notifications_outlined,
        activeIcon: Icons.notifications_rounded,
        label: 'Alerts'),
    CurvedNavigationItemPro(
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings_rounded,
        label: 'Settings'),
  ];

  List<CurvedNavigationItemPro> get _items =>
      _allItems.take(_p.itemCount).toList();

  void _update(_Params p) => setState(() {
        _p = p;
        if (_navIndex >= p.itemCount) _navIndex = 0;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D14),
      body: Column(
        children: [
          // ── Top title bar ──────────────────────────────────────────────────
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Playground',
                      style: TextStyle(
                        color: _p.activeColor,
                        fontSize: 20,
                        fontFamily: 'packages/curved_navigation_bar_pro/sora',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                      ),
                      children: [
                        TextSpan(
                          text: ' Section',
                          style: TextStyle(
                            color: _p.activeColor.withValues(alpha: 0.7),
                            fontSize: 20,
                            fontFamily:
                                'packages/curved_navigation_bar_pro/sora',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => setState(() {
                      _p = const _Params();
                      _navIndex = 0;
                    }),
                    // icon: const Icon(Icons.refresh_rounded, size: 15),
                    label: const Text('Reset',
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0,
                            fontFamily:
                                'packages/curved_navigation_bar_pro/sora',
                            fontWeight: FontWeight.w400)),
                    style: TextButton.styleFrom(
                      backgroundColor: _p.activeColor.withValues(alpha: 0.18),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Live preview ───────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Phone mockup frame
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A28),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: 0.07)),
                  ),
                  child: Column(
                    children: [
                      // Fake screen content
                      SizedBox(
                        height: 120,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _items[_navIndex.clamp(0, _items.length - 1)]
                                        .activeIcon ??
                                    _items[_navIndex.clamp(
                                            0, _items.length - 1)]
                                        .icon,
                                color: _p.activeColor,
                                size: 36,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _items[_navIndex.clamp(0, _items.length - 1)]
                                    .label,
                                style: TextStyle(
                                  color: _p.activeColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  letterSpacing: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // The actual nav bar
                      CurvedNavigationBarPro(
                        items: _items,
                        currentIndex: _navIndex.clamp(0, _items.length - 1),
                        onTap: (i) => setState(() => _navIndex = i),
                        backgroundColor: _p.backgroundColor,
                        activeColor: _p.activeColor,
                        fabColor: _p.activeColor,
                        activeIconColor: Colors.white,
                        barHeight: _p.barHeight,
                        fabRadius: _p.fabRadius,
                        fabGap: _p.fabGap,
                        fabSink: _p.fabSink,
                        notchShoulderRadius: _p.notchShoulderRadius,
                        cornerRadius: _p.cornerRadius,
                        elevation: _p.elevation,
                        shadowColor: Colors.black38,
                        animationDuration:
                            Duration(milliseconds: _p.animDurationMs.round()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Controls panel ─────────────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              children: [
                // Section: Geometry
                _SliderRow(
                  label: 'barHeight',
                  value: _p.barHeight,
                  min: 70,
                  max: 150,
                  color: _p.activeColor,
                  onChanged: (v) => _update(_p.copyWith(barHeight: v)),
                ),
                _SliderRow(
                  label: 'fabRadius',
                  value: _p.fabRadius,
                  min: 16,
                  max: 40,
                  color: _p.activeColor,
                  onChanged: (v) => _update(_p.copyWith(fabRadius: v)),
                ),
                _SliderRow(
                  label: 'fabGap',
                  value: _p.fabGap,
                  min: 0,
                  max: 24,
                  color: _p.activeColor,
                  onChanged: (v) => _update(_p.copyWith(fabGap: v)),
                ),
                _SliderRow(
                  label: 'fabSink',
                  value: _p.fabSink,
                  min: 0,
                  max: _p.fabRadius,
                  color: _p.activeColor,
                  onChanged: (v) => _update(_p.copyWith(fabSink: v)),
                ),
                _SliderRow(
                  label: 'notchShoulderRadius',
                  value: _p.notchShoulderRadius,
                  min: 0,
                  max: 28,
                  color: _p.activeColor,
                  onChanged: (v) =>
                      _update(_p.copyWith(notchShoulderRadius: v)),
                ),
                _SliderRow(
                  label: 'cornerRadius',
                  value: _p.cornerRadius,
                  min: 0,
                  max: 40,
                  color: _p.activeColor,
                  onChanged: (v) => _update(_p.copyWith(cornerRadius: v)),
                ),

                const SizedBox(height: 12),

                // Section: Shadow & Animation
                _SliderRow(
                  label: 'elevation',
                  value: _p.elevation,
                  min: 0,
                  max: 30,
                  color: _p.activeColor,
                  onChanged: (v) => _update(_p.copyWith(elevation: v)),
                ),
                _SliderRow(
                  label: 'animDuration (ms)',
                  value: _p.animDurationMs,
                  min: 100,
                  max: 1000,
                  divisions: 18,
                  color: _p.activeColor,
                  onChanged: (v) => _update(_p.copyWith(animDurationMs: v)),
                ),

                const SizedBox(height: 12),

                // Section: Items
                _SliderRow(
                  label: 'itemCount',
                  value: _p.itemCount.toDouble(),
                  min: 2,
                  max: 6,
                  divisions: 4,
                  color: _p.activeColor,
                  showInt: true,
                  onChanged: (v) => _update(_p.copyWith(itemCount: v.round())),
                ),

                const SizedBox(height: 12),

                // Section: Colour
                const SizedBox(height: 8),

                // Active colour picker
                _PickerLabel(label: 'activeColor', color: _p.activeColor),
                const SizedBox(height: 6),
                Row(
                  children: _palette.map((c) {
                    final selected = c == _p.activeColor;
                    return GestureDetector(
                      onTap: () => _update(_p.copyWith(activeColor: c)),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        width: selected ? 34 : 28,
                        height: selected ? 34 : 28,
                        decoration: BoxDecoration(
                          color: c,
                          shape: BoxShape.circle,
                          border: selected
                              ? Border.all(color: Colors.white, width: 2.5)
                              : null,
                          boxShadow: selected
                              ? [
                                  BoxShadow(
                                      color: c.withValues(alpha: 0.6),
                                      blurRadius: 10)
                                ]
                              : null,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),

                // Bar background picker
                _PickerLabel(label: 'backgroundColor', color: _p.activeColor),
                const SizedBox(height: 6),
                Row(
                  children: List.generate(_bgOptions.length, (i) {
                    final c = _bgOptions[i];
                    final selected = c == _p.backgroundColor;
                    return GestureDetector(
                      onTap: () => _update(_p.copyWith(backgroundColor: c)),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: c,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selected ? _p.activeColor : Colors.white24,
                            width: selected ? 2 : 1,
                          ),
                          boxShadow: selected
                              ? [
                                  BoxShadow(
                                      color:
                                          _p.activeColor.withValues(alpha: 0.4),
                                      blurRadius: 8)
                                ]
                              : null,
                        ),
                        child: Text(
                          _bgLabels[i],
                          style: TextStyle(
                            color: c == Colors.white ||
                                    c == const Color(0xFFF5F0FF) ||
                                    c == const Color(0xFFE8F5E9) ||
                                    c == const Color(0xFFFFF3E0)
                                ? Colors.black87
                                : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PickerLabel extends StatelessWidget {
  const _PickerLabel({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.color,
    this.divisions,
    this.showInt = false,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final Color color;
  final int? divisions;
  final bool showInt;

  @override
  Widget build(BuildContext context) {
    final display =
        showInt ? value.round().toString() : value.toStringAsFixed(1);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 148,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: color,
                thumbColor: color,
                inactiveTrackColor: color.withValues(alpha: 0.18),
                overlayColor: color.withValues(alpha: 0.12),
                trackHeight: 2.5,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
              ),
              child: Slider(
                value: value.clamp(min, max),
                min: min,
                max: max,
                divisions: divisions,
                onChanged: onChanged,
              ),
            ),
          ),
          SizedBox(
            width: 38,
            child: Text(
              display,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
