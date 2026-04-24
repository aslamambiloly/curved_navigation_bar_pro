import 'package:curved_navigation_bar_pro/curved_navigation_bar_pro.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ShowcaseApp());

class ShowcaseApp extends StatelessWidget {
  const ShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CurvedNavBarPro – Style Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF6C63FF),
        useMaterial3: true,
        fontFamily: 'packages/curved_navigation_bar_pro/sora',
      ),
      home: const ShowcasePage(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Top-level page
// ─────────────────────────────────────────────────────────────────────────────
class ShowcasePage extends StatelessWidget {
  const ShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      'Style Showcase',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'packages/curved_navigation_bar_pro/sora',
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '5 ready-to-use CurvedNavigationBarPro styles',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                        fontFamily: 'packages/curved_navigation_bar_pro/sora',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),

          // ── Style cards ─────────────────────────────────────────────────
          SliverList(
            delegate: SliverChildListDelegate([
              const _StyleCard(
                index: 1,
                title: 'Classic Indigo',
                subtitle: 'Clean white bar · deep violet accent',
                child: _Style1(),
              ),
              const _StyleCard(
                index: 2,
                title: 'Deep Space Dark',
                subtitle: 'Dark charcoal bar · cyan neon accent',
                child: _Style2(),
              ),
              const _StyleCard(
                index: 3,
                title: 'Rounded Coral',
                subtitle: 'Rounded corners · warm coral gradient accent',
                child: _Style3(),
              ),
              const _StyleCard(
                index: 4,
                title: 'Minimal Mono',
                subtitle: 'Flat sink · no shoulder · monochrome',
                child: _Style4(),
              ),
              const _StyleCard(
                index: 5,
                title: 'Emerald Pill',
                subtitle: 'Large FAB · deep sink · rich green · 5 items',
                child: _Style5(),
              ),
              const SizedBox(height: 32),
            ]),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Reusable card shell
// ─────────────────────────────────────────────────────────────────────────────
class _StyleCard extends StatelessWidget {
  const _StyleCard({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF15151F),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
        ),
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
                      '$index',
                      style: TextStyle(
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
                          title,
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
                          subtitle,
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
                ],
              ),
            ),

            const Divider(color: Colors.white10, height: 1),

            // Nav bar preview area
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Shared stateful wrapper – handles index + animated content
// ─────────────────────────────────────────────────────────────────────────────
class _NavPreview extends StatefulWidget {
  const _NavPreview({
    required this.navBar,
    required this.bgColor,
    required this.accentColor,
    required this.items,
  });

  /// Builder receives the current index so the caller can wire it up.
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
          // Fake screen content
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
          // The actual navbar
          widget.navBar(_index, (i) => setState(() => _index = i)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  STYLE 1 – Classic Indigo
//  White bar, indigo accent, standard geometry, gentle shadow
// ─────────────────────────────────────────────────────────────────────────────
class _Style1 extends StatelessWidget {
  const _Style1();

  static const _items = [
    CurvedNavigationItemPro(
        inactiveIcon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
        label: 'Home'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.search_outlined,
        activeIcon: Icons.search_rounded,
        label: 'Search'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.favorite_outline,
        activeIcon: Icons.favorite_rounded,
        label: 'Saved'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.person_outline_rounded,
        activeIcon: Icons.person_rounded,
        label: 'Profile'),
  ];

  static const _accent = Color(0xFF6C63FF);

  @override
  Widget build(BuildContext context) {
    return _NavPreview(
      bgColor: const Color(0xFFF4F6FA),
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
        inactiveColor: const Color(0xFFADB5BD),
        barHeight: 100,
        fabRadius: 24,
        fabGap: 10,
        fabSink: 22,
        notchShoulderRadius: 12,
        cornerRadius: 0,
        elevation: 14,
        shadowColor: Colors.black26,
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.easeInOutCubic,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  STYLE 2 – Deep Space Dark
//  Charcoal bar, cyan accent, deep sink, zero shoulder (sharp notch)
// ─────────────────────────────────────────────────────────────────────────────
class _Style2 extends StatelessWidget {
  const _Style2();

  static const _items = [
    CurvedNavigationItemPro(
        inactiveIcon: Icons.dashboard_outlined,
        activeIcon: Icons.dashboard_rounded,
        label: 'Dash'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.explore_outlined,
        activeIcon: Icons.explore_rounded,
        label: 'Explore'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.notifications_outlined,
        activeIcon: Icons.notifications_rounded,
        label: 'Alerts'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.settings_outlined,
        activeIcon: Icons.settings_rounded,
        label: 'Settings'),
  ];

  static const _accent = Color(0xFF00E5FF);
  static const _barBg = Color(0xFF1A1A2E);

  @override
  Widget build(BuildContext context) {
    return _NavPreview(
      bgColor: const Color(0xFF0D0D1A),
      accentColor: _accent,
      items: _items,
      navBar: (index, onTap) => CurvedNavigationBarPro(
        items: _items,
        currentIndex: index,
        onTap: onTap,
        backgroundColor: _barBg,
        activeColor: _accent,
        fabColor: _accent,
        activeIconColor: const Color(0xFF0D0D1A),
        inactiveColor: const Color(0xFF4A4A6A),
        barHeight: 108,
        fabRadius: 26,
        fabGap: 8,
        fabSink: 26,
        notchShoulderRadius: 0, // sharp notch
        cornerRadius: 0,
        elevation: 20,
        shadowColor: _accent.withValues(alpha: 0.25),
        animationDuration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeOutBack,
        activeTextStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
          color: _accent,
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
        inactiveTextStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.3,
          color: Color(0xFF4A4A6A),
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  STYLE 3 – Rounded Coral
//  Rounded top corners, coral/pink accent, large shoulder radius for smooth notch
// ─────────────────────────────────────────────────────────────────────────────
class _Style3 extends StatelessWidget {
  const _Style3();

  static const _items = [
    CurvedNavigationItemPro(
        inactiveIcon: Icons.storefront_outlined,
        activeIcon: Icons.storefront_rounded,
        label: 'Shop'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.shopping_bag_outlined,
        activeIcon: Icons.shopping_bag_rounded,
        label: 'Bag'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.local_offer_outlined,
        activeIcon: Icons.local_offer_rounded,
        label: 'Deals'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.person_outline_rounded,
        activeIcon: Icons.person_rounded,
        label: 'Me'),
  ];

  static const _accent = Color(0xFFFF6B6B);

  @override
  Widget build(BuildContext context) {
    return _NavPreview(
      bgColor: const Color(0xFFFFF5F5),
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
        inactiveColor: const Color(0xFFCCBBBB),
        barHeight: 106,
        fabRadius: 25,
        fabGap: 10,
        fabSink: 20,
        notchShoulderRadius: 20, // very smooth notch shoulders
        cornerRadius: 28, // pill-shaped top corners
        elevation: 10,
        shadowColor: _accent.withValues(alpha: 0.20),
        animationDuration: const Duration(milliseconds: 480),
        animationCurve: Curves.easeInOutSine,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  STYLE 4 – Minimal Mono
//  Flat white bar, FAB fully inside (max sink), no shoulder, 3 items, slate accent
// ─────────────────────────────────────────────────────────────────────────────
class _Style4 extends StatelessWidget {
  const _Style4();

  static const _items = [
    CurvedNavigationItemPro(
        inactiveIcon: Icons.grid_view_outlined,
        activeIcon: Icons.grid_view_rounded,
        label: 'Feed'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.photo_camera_outlined,
        activeIcon: Icons.photo_camera_rounded,
        label: 'Camera'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.inbox_outlined,
        activeIcon: Icons.inbox_rounded,
        label: 'Inbox'),
  ];

  static const _accent = Color(0xFF2D3748);

  @override
  Widget build(BuildContext context) {
    return _NavPreview(
      bgColor: const Color(0xFFF7F8FA),
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
        inactiveColor: const Color(0xFFCBD5E0),
        barHeight: 96,
        fabRadius: 22,
        fabGap: 6,
        fabSink: 22, // fully inside – flush with bar top
        notchShoulderRadius: 0,
        cornerRadius: 0,
        elevation: 6,
        shadowColor: Colors.black12,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeOut,
        activeTextStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
          color: _accent,
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
        inactiveTextStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: Color(0xFFCBD5E0),
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  STYLE 5 – Emerald Pill
//  Dark green bar, large protruding FAB, 5 items, elastic animation
// ─────────────────────────────────────────────────────────────────────────────
class _Style5 extends StatelessWidget {
  const _Style5();

  static const _items = [
    CurvedNavigationItemPro(
        inactiveIcon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
        label: 'Home'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.map_outlined,
        activeIcon: Icons.map_rounded,
        label: 'Map'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.eco_outlined,
        activeIcon: Icons.eco_rounded,
        label: 'Nature'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.star_outline_rounded,
        activeIcon: Icons.star_rounded,
        label: 'Stars'),
    CurvedNavigationItemPro(
        inactiveIcon: Icons.account_circle_outlined,
        activeIcon: Icons.account_circle_rounded,
        label: 'Account'),
  ];

  static const _accent = Color(0xFF00C896);
  static const _barBg = Color(0xFF0F2D26);

  @override
  Widget build(BuildContext context) {
    return _NavPreview(
      bgColor: const Color(0xFF071A14),
      accentColor: _accent,
      items: _items,
      navBar: (index, onTap) => CurvedNavigationBarPro(
        items: _items,
        currentIndex: index,
        onTap: onTap,
        backgroundColor: _barBg,
        activeColor: _accent,
        fabColor: _accent,
        activeIconColor: const Color(0xFF071A14),
        inactiveColor: const Color(0xFF2E5448),
        barHeight: 112,
        fabRadius: 30, // large FAB
        fabGap: 12,
        fabSink: 10, // strongly protruding
        notchShoulderRadius: 16,
        cornerRadius: 20, // rounded top edges
        elevation: 18,
        shadowColor: _accent.withValues(alpha: 0.30),
        animationDuration: const Duration(milliseconds: 500),
        animationCurve: Curves.easeInOutBack,
        activeTextStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: _accent,
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
        inactiveTextStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Color(0xFF2E5448),
          fontFamily: 'packages/curved_navigation_bar_pro/sora',
        ),
      ),
    );
  }
}
