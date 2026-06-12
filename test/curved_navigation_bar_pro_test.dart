// ignore_for_file: avoid_redundant_argument_values

import 'package:curved_navigation_bar_pro/curved_navigation_bar_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  Shared fixtures
// ─────────────────────────────────────────────────────────────────────────────

const _items = [
  CurvedNavigationItemPro(
    inactiveIcon: Icons.home_outlined,
    activeIcon: Icons.home,
    label: 'HOME',
  ),
  CurvedNavigationItemPro(inactiveIcon: Icons.search, label: 'SEARCH'),
  CurvedNavigationItemPro(inactiveIcon: Icons.favorite_outline, label: 'SAVED'),
  CurvedNavigationItemPro(inactiveIcon: Icons.person_outline, label: 'PROFILE'),
];

Widget _buildApp({
  int index = 0,
  ValueChanged<int>? onTap,
  List<CurvedNavigationItemPro>? items,
  Color? backgroundColor,
  Color? activeColor,
  Color? fabColor,
  Color? inactiveColor,
  bool? showLabel,
}) {
  return MaterialApp(
    home: Scaffold(
      bottomNavigationBar: CurvedNavigationBarPro(
        items: items ?? _items,
        currentIndex: index,
        onTap: onTap ?? (_) {},
        backgroundColor: backgroundColor,
        activeColor: activeColor,
        fabColor: fabColor,
        inactiveColor: inactiveColor,
        showLabel: showLabel,
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
//  Tests
// ─────────────────────────────────────────────────────────────────────────────

void main() {
  group('CurvedNavigationBarPro', () {
    // ── Rendering ─────────────────────────────────────────────────────────────

    testWidgets('renders all item labels', (tester) async {
      await tester.pumpWidget(_buildApp());
      for (final item in _items) {
        expect(find.text(item.label), findsOneWidget);
      }
    });

    testWidgets('renders with showLabel false — no label text visible',
        (tester) async {
      await tester.pumpWidget(_buildApp(showLabel: false));
      for (final item in _items) {
        expect(find.text(item.label), findsNothing);
      }
    });

    testWidgets('renders with minimum 2 items', (tester) async {
      const twoItems = [
        CurvedNavigationItemPro(inactiveIcon: Icons.home, label: 'A'),
        CurvedNavigationItemPro(inactiveIcon: Icons.search, label: 'B'),
      ];
      await tester.pumpWidget(_buildApp(items: twoItems));
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
    });

    testWidgets('renders with maximum 6 items', (tester) async {
      const sixItems = [
        CurvedNavigationItemPro(inactiveIcon: Icons.home, label: 'A'),
        CurvedNavigationItemPro(inactiveIcon: Icons.search, label: 'B'),
        CurvedNavigationItemPro(inactiveIcon: Icons.star, label: 'C'),
        CurvedNavigationItemPro(inactiveIcon: Icons.person, label: 'D'),
        CurvedNavigationItemPro(inactiveIcon: Icons.settings, label: 'E'),
        CurvedNavigationItemPro(inactiveIcon: Icons.notifications, label: 'F'),
      ];
      await tester.pumpWidget(_buildApp(items: sixItems));
      for (final item in sixItems) {
        expect(find.text(item.label), findsOneWidget);
      }
    });

    // ── Interaction ───────────────────────────────────────────────────────────

    testWidgets('calls onTap with correct index when tapping a label',
        (tester) async {
      int? tappedIndex;
      await tester.pumpWidget(_buildApp(onTap: (i) => tappedIndex = i));

      await tester.tap(find.text('SEARCH'));
      await tester.pumpAndSettle();

      expect(tappedIndex, equals(1));
    });

    testWidgets('calls onTap with correct index for each item', (tester) async {
      final tapped = <int>[];
      await tester.pumpWidget(_buildApp(onTap: tapped.add));

      for (var i = 0; i < _items.length; i++) {
        await tester.tap(find.text(_items[i].label));
        await tester.pumpAndSettle();
      }

      expect(tapped, equals([0, 1, 2, 3]));
    });

    // ── Animation ─────────────────────────────────────────────────────────────

    testWidgets('animation completes cleanly when currentIndex changes',
        (tester) async {
      await tester.pumpWidget(_buildApp(index: 0));
      await tester.pumpWidget(_buildApp(index: 2));
      await tester.pumpAndSettle();
      expect(find.text('SAVED'), findsOneWidget);
    });

    testWidgets('rapid index changes complete without errors', (tester) async {
      await tester.pumpWidget(_buildApp(index: 0));
      await tester.pumpWidget(_buildApp(index: 3));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpWidget(_buildApp(index: 1));
      await tester.pumpAndSettle();
      expect(find.text('SEARCH'), findsOneWidget);
    });

    // ── Assertions ────────────────────────────────────────────────────────────

    testWidgets('throws assertion for fewer than 2 items', (tester) async {
      expect(
        () => CurvedNavigationBarPro(
          items: const [
            CurvedNavigationItemPro(inactiveIcon: Icons.home, label: 'HOME'),
          ],
          onTap: (_) {},
        ),
        throwsAssertionError,
      );
    });

    testWidgets('throws assertion for more than 6 items', (tester) async {
      const many = [
        CurvedNavigationItemPro(inactiveIcon: Icons.home, label: 'A'),
        CurvedNavigationItemPro(inactiveIcon: Icons.home, label: 'B'),
        CurvedNavigationItemPro(inactiveIcon: Icons.home, label: 'C'),
        CurvedNavigationItemPro(inactiveIcon: Icons.home, label: 'D'),
        CurvedNavigationItemPro(inactiveIcon: Icons.home, label: 'E'),
        CurvedNavigationItemPro(inactiveIcon: Icons.home, label: 'F'),
        CurvedNavigationItemPro(inactiveIcon: Icons.home, label: 'G'),
      ];
      expect(
        () => CurvedNavigationBarPro(items: many, onTap: (_) {}),
        throwsAssertionError,
      );
    });

    testWidgets('throws assertion for out-of-range currentIndex',
        (tester) async {
      expect(
        () => CurvedNavigationBarPro(
          items: _items,
          currentIndex: 99,
          onTap: (_) {},
        ),
        throwsAssertionError,
      );
    });

    // ── Theming ───────────────────────────────────────────────────────────────

    testWidgets('accepts custom colors without throwing', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          backgroundColor: Colors.black,
          activeColor: Colors.amber,
          fabColor: Colors.deepOrange,
          inactiveColor: Colors.white54,
        ),
      );
      expect(find.text('HOME'), findsOneWidget);
    });

    testWidgets('renders correctly with goldenHour style preset',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: CurvedNavigationBarPro(
              items: _items,
              currentIndex: 0,
              onTap: (_) {},
              navbarStyle: CNBPStyles.goldenHour,
            ),
          ),
        ),
      );
      expect(find.text('HOME'), findsOneWidget);
    });

    testWidgets('renders correctly with deepSpaceDark style preset',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: CurvedNavigationBarPro(
              items: _items,
              currentIndex: 0,
              onTap: (_) {},
              navbarStyle: CNBPStyles.deepSpaceDark,
            ),
          ),
        ),
      );
      expect(find.text('HOME'), findsOneWidget);
    });

    testWidgets('explicit param overrides style preset', (tester) async {
      // fabRadius: 40 should override the preset's fabRadius without throwing.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: CurvedNavigationBarPro(
              items: _items,
              currentIndex: 0,
              onTap: (_) {},
              navbarStyle: CNBPStyles.roundedCoral,
              fabRadius: 40,
            ),
          ),
        ),
      );
      expect(find.text('HOME'), findsOneWidget);
    });

    // ── Semantics (Option B) ──────────────────────────────────────────────────
    //
    // _NavItemTile already wraps each item in:
    //   Semantics(label: item.label, selected: isActive, button: true, …)
    //
    // Flutter may surface a label on more than one merged node, so we use
    // findsWidgets instead of findsOneWidget, and ensureSemantics() to force
    // the semantics tree to be built during tests.

    testWidgets('each item has a semantics node labelled with its text',
        (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      final handle = tester.ensureSemantics();

      for (final item in _items) {
        expect(
          find.bySemanticsLabel(item.label),
          findsWidgets,
          reason: 'Expected a semantics node labelled "${item.label}"',
        );
      }

      handle.dispose();
    });

    testWidgets('active item semantics node is marked as selected',
        (tester) async {
      await tester.pumpWidget(_buildApp(index: 1)); // SEARCH active
      await tester.pumpAndSettle();

      final handle = tester.ensureSemantics();

      final node = tester.getSemantics(find.bySemanticsLabel('SEARCH').first);
      expect(
        node.hasFlag(SemanticsFlag.isSelected),
        isTrue,
        reason: 'Active item should carry the isSelected semantics flag',
      );

      handle.dispose();
    });

    testWidgets('inactive item semantics node is NOT marked as selected',
        (tester) async {
      await tester
          .pumpWidget(_buildApp(index: 0)); // HOME active, SEARCH inactive
      await tester.pumpAndSettle();

      final handle = tester.ensureSemantics();

      final node = tester.getSemantics(find.bySemanticsLabel('SEARCH').first);
      expect(
        node.hasFlag(SemanticsFlag.isSelected),
        isFalse,
        reason: 'Inactive item should NOT carry the isSelected flag',
      );

      handle.dispose();
    });

    testWidgets('all items are marked as buttons in the semantics tree',
        (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      final handle = tester.ensureSemantics();

      for (final item in _items) {
        final node =
            tester.getSemantics(find.bySemanticsLabel(item.label).first);
        expect(
          node.hasFlag(SemanticsFlag.isButton),
          isTrue,
          reason: '"${item.label}" should be a button in the semantics tree',
        );
      }

      handle.dispose();
    });

    // ── Custom widget items ───────────────────────────────────────────────────

    testWidgets('renders custom inactiveWidget without throwing', (tester) async {
      final customItems = [
        CurvedNavigationItemPro(
          inactiveWidget: const Icon(Icons.home, color: Colors.grey),
          activeWidget: const Icon(Icons.home, color: Colors.white),
          label: 'HOME',
        ),
        const CurvedNavigationItemPro(
            inactiveIcon: Icons.search, label: 'SEARCH'),
      ];
      await tester.pumpWidget(_buildApp(items: customItems));
      expect(find.text('HOME'), findsOneWidget);
    });

    // ── Badge ─────────────────────────────────────────────────────────────────

    testWidgets('renders badge text on an item', (tester) async {
      const badgedItems = [
        CurvedNavigationItemPro(
          inactiveIcon: Icons.notifications_outlined,
          label: 'ALERTS',
          badgeText: '3',
        ),
        CurvedNavigationItemPro(inactiveIcon: Icons.home, label: 'HOME'),
      ];
      await tester.pumpWidget(_buildApp(items: badgedItems));
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('renders dot badge without throwing', (tester) async {
      const badgedItems = [
        CurvedNavigationItemPro(
          inactiveIcon: Icons.notifications_outlined,
          label: 'ALERTS',
          badgeText: '•',
        ),
        CurvedNavigationItemPro(inactiveIcon: Icons.home, label: 'HOME'),
      ];
      await tester.pumpWidget(_buildApp(items: badgedItems));
      expect(find.text('ALERTS'), findsOneWidget);
    });

    testWidgets('renders custom badge widget without throwing', (tester) async {
      final badgedItems = [
        CurvedNavigationItemPro(
          inactiveIcon: Icons.notifications_outlined,
          label: 'ALERTS',
          badgeWidget: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const CurvedNavigationItemPro(inactiveIcon: Icons.home, label: 'HOME'),
      ];
      await tester.pumpWidget(_buildApp(items: badgedItems));
      expect(find.text('ALERTS'), findsOneWidget);
    });
  });
}
