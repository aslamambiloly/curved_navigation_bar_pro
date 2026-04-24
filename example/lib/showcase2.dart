import 'package:curved_navigation_bar_pro/curved_navigation_bar_pro.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  Entry point
//  Try passing initialStyle: 3 to jump straight to a specific card.
//  e.g.  home: const ShowcasePage2(initialStyle: 3),
// ─────────────────────────────────────────────────────────────────────────────
void main() => runApp(const ShowcaseApp2());

class ShowcaseApp2 extends StatelessWidget {
  const ShowcaseApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CurvedNavBarPro – Style Showcase II',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF6C63FF),
        useMaterial3: true,
        fontFamily: 'packages/curved_navigation_bar_pro/sora',
      ),
      // ↓ Change this to jump straight to any style (1–5)
      home: const ShowcasePage2(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  ShowcasePage2
//
//  [initialStyle] — optional 1-based index of the style card to scroll to and
//  highlight on first render. Pass null (the default) to show all cards at the
//  top without any highlight.
// ─────────────────────────────────────────────────────────────────────────────
class ShowcasePage2 extends StatefulWidget {
  const ShowcasePage2({super.key, this.initialStyle});

  /// 1-based index of the style to highlight on open (1 = first card).
  /// Out-of-range values are silently ignored.
  final int? initialStyle;

  @override
  State<ShowcasePage2> createState() => _ShowcasePage2State();
}

class _ShowcasePage2State extends State<ShowcasePage2> {
  // One GlobalKey per card so we can scroll & highlight programmatically.
  static const _styleCount = 5;
  final List<GlobalKey> _cardKeys =
      List.generate(_styleCount, (_) => GlobalKey());

  int? get _highlightIdx {
    final s = widget.initialStyle;
    if (s == null || s < 1 || s > _styleCount) return null;
    return s - 1; // convert to 0-based
  }

  @override
  void initState() {
    super.initState();
    if (_highlightIdx != null) {
      // Wait one frame so the scroll view has been laid out.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final ctx = _cardKeys[_highlightIdx!].currentContext;
        if (ctx != null) {
          Scrollable.ensureVisible(
            ctx,
            duration: const Duration(milliseconds: 650),
            curve: Curves.easeInOutCubic,
            alignment: 0.08, // a little breathing room at the top
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final styles = [
      _StyleEntry(
        key: _cardKeys[0],
        index: 6,
        title: 'Sunset Amber',
        subtitle: 'Warm amber · travel theme · smooth shoulders',
        child: const _Style6(),
      ),
      _StyleEntry(
        key: _cardKeys[1],
        index: 7,
        title: 'Royal Amethyst',
        subtitle: 'Deep navy bar · lavender accent · 3 items · protruding FAB',
        child: const _Style7(),
      ),
      _StyleEntry(
        key: _cardKeys[2],
        index: 8,
        title: 'Arctic Frost',
        subtitle: 'Light steel bar · steel blue · fully sunk FAB · pill corners',
        child: const _Style8(),
      ),
      _StyleEntry(
        key: _cardKeys[3],
        index: 9,
        title: 'Berry Blossom',
        subtitle: 'Dark bar · hot pink · 5 items · ultra-smooth notch',
        child: const _Style9(),
      ),
      _StyleEntry(
        key: _cardKeys[4],
        index: 10,
        title: 'Golden Hour',
        subtitle: 'Ink-black bar · pure gold accent · finance theme',
        child: const _Style10(),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D14),
      body: CustomScrollView(
        slivers: [
          // ── Header ──────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Style Showcase',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  fontFamily:
                                      'packages/curved_navigation_bar_pro/sora',
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '5 more CurvedNavigationBarPro styles — Vol. II',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 13,
                                  fontFamily:
                                      'packages/curved_navigation_bar_pro/sora',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Volume badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.07),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.white.withValues(alpha: 0.10)),
                          ),
                          child: const Text(
                            'Vol. II',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  'packages/curved_navigation_bar_pro/sora',
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Show "jump hint" when initialStyle is set
                    if (_highlightIdx != null) ...[
                      const SizedBox(height: 16),
                      _JumpBanner(
                        styleNumber: widget.initialStyle!,
                        styleName: styles[_highlightIdx!].title,
                      ),
                    ],
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // ── Style cards ─────────────────────────────────────────────────
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                if (i == styles.length) return const SizedBox(height: 36);
                final entry = styles[i];
                final highlighted =
                    _highlightIdx != null && _highlightIdx == i;
                return _StyleCard(
                  key: entry.key,
                  index: entry.index,
                  title: entry.title,
                  subtitle: entry.subtitle,
                  highlighted: highlighted,
                  child: entry.child,
                );
              },
              childCount: styles.length + 1,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Internal data holder for each style entry
// ─────────────────────────────────────────────────────────────────────────────
class _StyleEntry {
  const _StyleEntry({
    required this.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final GlobalKey key;
  final int index;
  final String title;
  final String subtitle;
  final Widget child;
}

// ─────────────────────────────────────────────────────────────────────────────
//  Jump banner – shown at the top when initialStyle is provided
// ─────────────────────────────────────────────────────────────────────────────
class _JumpBanner extends StatelessWidget {
  const _JumpBanner({required this.styleNumber, required this.styleName});
  final int styleNumber;
  final String styleName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF6C63FF).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: const Color(0xFF6C63FF).withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          const Icon(Icons.arrow_downward_rounded,
              color: Color(0xFF9D97FF), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: 'Jumping to  ',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontFamily: 'packages/curved_navigation_bar_pro/sora',
                ),
                children: [
                  TextSpan(
                    text: 'Style $styleNumber · $styleName',
                    style: const TextStyle(
                      color: Color(0xFF9D97FF),
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Reusable card shell (same design language as showcase.dart)
//  [highlighted] adds an accent glow border when the card was jumped to.
// ─────────────────────────────────────────────────────────────────────────────
class _StyleCard extends StatefulWidget {
  const _StyleCard({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.child,
    this.highlighted = false,
  });

  final int index;
  final String title;
  final String subtitle;
  final Widget child;
  final bool highlighted;

  @override
  State<_StyleCard> createState() => _StyleCardState();
}

class _StyleCardState extends State<_StyleCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glowCtrl;
  late final Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _glowAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    if (widget.highlighted) {
      // Wait for scroll to arrive, then pulse the glow twice
      Future.delayed(const Duration(milliseconds: 700), () {
        if (mounted) _glowCtrl.repeat(reverse: true, period: const Duration(milliseconds: 900));
        Future.delayed(const Duration(milliseconds: 2800), () {
          if (mounted) _glowCtrl.animateTo(0);
        });
      });
    }
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnim,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF15151F),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: widget.highlighted
                    ? Color.lerp(
                        Colors.white.withValues(alpha: 0.07),
                        const Color(0xFF6C63FF).withValues(alpha: 0.7),
                        _glowAnim.value,
                      )!
                    : Colors.white.withValues(alpha: 0.07),
                width: widget.highlighted
                    ? 1.0 + _glowAnim.value * 0.8
                    : 1.0,
              ),
              boxShadow: widget.highlighted
                  ? [
                      BoxShadow(
                        color: const Color(0xFF6C63FF)
                            .withValues(alpha: 0.18 * _glowAnim.value),
                        blurRadius: 24,
                        spreadRadius: 2,
                      )
                    ]
                  : null,
            ),
            child: child!,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Row(
              children: [
                // Index badge
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${widget.index}',
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'packages/curved_navigation_bar_pro/sora',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          fontFamily:
                              'packages/curved_navigation_bar_pro/sora',
                          letterSpacing: 0,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily:
                              'packages/curved_navigation_bar_pro/sora',
                        ),
                      ),
                    ],
                  ),
                ),

                // "Highlighted" pin badge
                if (widget.highlighted)
                  AnimatedBuilder(
                    animation: _glowAnim,
                    builder: (_, __) => Opacity(
                      opacity: 0.5 + _glowAnim.value * 0.5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF)
                              .withValues(alpha: 0.20),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'PINNED',
                          style: TextStyle(
                            color: Color(0xFF9D97FF),
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0,
                            fontFamily:
                                'packages/curved_navigation_bar_pro/sora',
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const Divider(color: Colors.white10, height: 1),

          // Nav bar preview area
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Shared stateful nav preview wrapper
// ─────────────────────────────────────────────────────────────────────────────
class _NavPreview extends StatefulWidget {
  const _NavPreview({
    required this.navBar,
    required this.bgColor,
    required this.accentColor,
    required this.items,
  });

  final Widget Function(int index, void Function(int) onTap) navBar;
  final Color bgColor;
  final Color accentColor;
  final List<CurvedNavigationItemPro> items;

  @override
  State<_NavPreview> createState() => _NavPreviewState();
}

class _NavPreviewState extends State<_NavPreview> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final item = widget.items[_index];
    final icon = item.activeIcon ?? item.inactiveIcon;

    return Container(
      color: widget.bgColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 90,
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Column(
                  key: ValueKey(_index),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: widget.accentColor, size: 28),
                    const SizedBox(height: 6),
                    Text(
                      item.label,
                      style: TextStyle(
                        color: widget.accentColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        fontFamily: 'packages/curved_navigation_bar_pro/sora',
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          widget.navBar(_index, (i) => setState(() => _index = i)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  STYLE 6 – Sunset Amber
//  White bar · warm amber accent · travel theme · smooth shoulders · easeInOutSine
// ─────────────────────────────────────────────────────────────────────────────
class _Style6 extends StatelessWidget {
  const _Style6();

  static const _accent = Color(0xFFFF9F43);
  static const _items = [
    CurvedNavigationItemPro(
        inactiveIcon: Icons.flight_outlined,
        activeIcon: Icons.flight_rounded,
        label: 'Flights'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.hotel_outlined,
        activeIcon: Icons.hotel_rounded,
        label: 'Hotels'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.explore_outlined,
        activeIcon: Icons.explore_rounded,
        label: 'Explore'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.person_outline_rounded,
        activeIcon: Icons.person_rounded,
        label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return _NavPreview(
      bgColor: const Color(0xFFFFF8F0),
      accentColor: _accent,
      items: _items,
      navBar: (index, onTap) => CurvedNavigationBarPro(
        items: _items,
        currentIndex: index,
        onTap: onTap,
        backgroundColor: Colors.white,
        activeColor: _accent,
        fabColor: _accent,
        activeIconColor: Colors.white,
        inactiveColor: const Color(0xFFD4C4B0),
        barHeight: 104,
        fabRadius: 26,
        fabGap: 12,
        fabSink: 18,
        notchShoulderRadius: 18, // smooth transition
        cornerRadius: 0,
        elevation: 12,
        shadowColor: _accent.withValues(alpha: 0.18),
        animationDuration: const Duration(milliseconds: 460),
        animationCurve: Curves.easeInOutSine,
        activeTextStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: _accent,
          letterSpacing: 0.3,
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
        inactiveTextStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: Color(0xFFD4C4B0),
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  STYLE 7 – Royal Amethyst
//  Deep navy · lavender accent · 3 items · strongly protruding FAB · easeOutBack
// ─────────────────────────────────────────────────────────────────────────────
class _Style7 extends StatelessWidget {
  const _Style7();

  static const _accent = Color(0xFFBE73FF);
  static const _barBg = Color(0xFF0E0829);
  static const _items = [
    CurvedNavigationItemPro(
        inactiveIcon: Icons.auto_awesome_outlined,
        activeIcon: Icons.auto_awesome_rounded,
        label: 'Magic'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.palette_outlined,
        activeIcon: Icons.palette_rounded,
        label: 'Create'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.account_circle_outlined,
        activeIcon: Icons.account_circle_rounded,
        label: 'You'),
  ];

  @override
  Widget build(BuildContext context) {
    return _NavPreview(
      bgColor: const Color(0xFF08051A),
      accentColor: _accent,
      items: _items,
      navBar: (index, onTap) => CurvedNavigationBarPro(
        items: _items,
        currentIndex: index,
        onTap: onTap,
        backgroundColor: _barBg,
        activeColor: _accent,
        fabColor: _accent,
        activeIconColor: const Color(0xFF08051A),
        inactiveColor: const Color(0xFF3D2A5C),
        barHeight: 106,
        fabRadius: 28,
        fabGap: 8,
        fabSink: 8,  // protruding FAB
        notchShoulderRadius: 14,
        cornerRadius: 0,
        elevation: 22,
        shadowColor: _accent.withValues(alpha: 0.28),
        animationDuration: const Duration(milliseconds: 380),
        animationCurve: Curves.easeOutBack,
        activeTextStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: _accent,
          letterSpacing: 1.0,
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
        inactiveTextStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFF3D2A5C),
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  STYLE 8 – Arctic Frost
//  Light steel bar · steel blue · fully sunk FAB · pill top corners · easeOut
// ─────────────────────────────────────────────────────────────────────────────
class _Style8 extends StatelessWidget {
  const _Style8();

  static const _accent = Color(0xFF2B6CB0);
  static const _items = [
    CurvedNavigationItemPro(
        inactiveIcon: Icons.wb_sunny_outlined,
        activeIcon: Icons.wb_sunny_rounded,
        label: 'Today'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.bar_chart_outlined,
        activeIcon: Icons.bar_chart_rounded,
        label: 'Stats'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.water_drop_outlined,
        activeIcon: Icons.water_drop_rounded,
        label: 'Hydro'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.settings_outlined,
        activeIcon: Icons.settings_rounded,
        label: 'Prefs'),
  ];

  @override
  Widget build(BuildContext context) {
    return _NavPreview(
      bgColor: const Color(0xFFE8EEF5),
      accentColor: _accent,
      items: _items,
      navBar: (index, onTap) => CurvedNavigationBarPro(
        items: _items,
        currentIndex: index,
        onTap: onTap,
        backgroundColor: const Color(0xFFF0F4F8),
        activeColor: _accent,
        fabColor: _accent,
        activeIconColor: Colors.white,
        inactiveColor: const Color(0xFFA0AEBE),
        barHeight: 98,
        fabRadius: 22,
        fabGap: 6,
        fabSink: 22, // fully sunk — flush with bar top
        notchShoulderRadius: 10,
        cornerRadius: 20, // pill top corners
        elevation: 6,
        shadowColor: Colors.blueGrey.withValues(alpha: 0.15),
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeOut,
        activeTextStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: _accent,
          letterSpacing: 0.3,
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
        inactiveTextStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: Color(0xFFA0AEBE),
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  STYLE 9 – Berry Blossom
//  Dark charcoal · hot pink · 5 items · ultra-smooth notch · elasticOut
// ─────────────────────────────────────────────────────────────────────────────
class _Style9 extends StatelessWidget {
  const _Style9();

  static const _accent = Color(0xFFFF6AC1);
  static const _barBg = Color(0xFF1C0A1C);
  static const _items = [
    CurvedNavigationItemPro(
        inactiveIcon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
        label: 'Home'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.chat_bubble_outline_rounded,
        activeIcon: Icons.chat_bubble_rounded,
        label: 'Chat'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.add_photo_alternate_outlined,
        activeIcon: Icons.add_photo_alternate_rounded,
        label: 'Post'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.notifications_outlined,
        activeIcon: Icons.notifications_rounded,
        label: 'Notify'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.person_outline_rounded,
        activeIcon: Icons.person_rounded,
        label: 'Me'),
  ];

  @override
  Widget build(BuildContext context) {
    return _NavPreview(
      bgColor: const Color(0xFF100510),
      accentColor: _accent,
      items: _items,
      navBar: (index, onTap) => CurvedNavigationBarPro(
        items: _items,
        currentIndex: index,
        onTap: onTap,
        backgroundColor: _barBg,
        activeColor: _accent,
        fabColor: _accent,
        activeIconColor: Colors.white,
        inactiveColor: const Color(0xFF4A1A4A),
        barHeight: 108,
        fabRadius: 24,
        fabGap: 10,
        fabSink: 14,
        notchShoulderRadius: 22, // ultra-smooth shoulders
        cornerRadius: 24,
        elevation: 20,
        shadowColor: _accent.withValues(alpha: 0.25),
        animationDuration: const Duration(milliseconds: 520),
        animationCurve: Curves.elasticOut,
        activeTextStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: _accent,
          letterSpacing: 0.5,
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
        inactiveTextStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Color(0xFF4A1A4A),
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  STYLE 10 – Golden Hour
//  Ink-black bar · pure gold accent · dark icon inside FAB · finance theme
// ─────────────────────────────────────────────────────────────────────────────
class _Style10 extends StatelessWidget {
  const _Style10();

  static const _accent = Color(0xFFFFD700);
  static const _barBg = Color(0xFF121008);
  static const _items = [
    CurvedNavigationItemPro(
        inactiveIcon: Icons.account_balance_wallet_outlined,
        activeIcon: Icons.account_balance_wallet_rounded,
        label: 'Wallet'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.show_chart_rounded,
        activeIcon: Icons.show_chart_rounded,
        label: 'Markets'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.receipt_long_outlined,
        activeIcon: Icons.receipt_long_rounded,
        label: 'History'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.person_outline_rounded,
        activeIcon: Icons.person_rounded,
        label: 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    return _NavPreview(
      bgColor: const Color(0xFF0A0804),
      accentColor: _accent,
      items: _items,
      navBar: (index, onTap) => CurvedNavigationBarPro(
        items: _items,
        currentIndex: index,
        onTap: onTap,
        backgroundColor: _barBg,
        activeColor: _accent,
        fabColor: _accent,
        activeIconColor: const Color(0xFF0A0804), // dark icon on gold
        inactiveColor: const Color(0xFF3A3218),
        barHeight: 104,
        fabRadius: 25,
        fabGap: 10,
        fabSink: 22,
        notchShoulderRadius: 12,
        cornerRadius: 12,
        elevation: 18,
        shadowColor: _accent.withValues(alpha: 0.22),
        animationDuration: const Duration(milliseconds: 420),
        animationCurve: Curves.easeInOutCubic,
        activeTextStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: _accent,
          letterSpacing: 0.8,
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
        inactiveTextStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: Color(0xFF3A3218),
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
      ),
    );
  }
}
