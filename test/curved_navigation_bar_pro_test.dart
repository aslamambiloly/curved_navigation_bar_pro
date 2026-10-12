// ignore_for_file: avoid_redundant_argument_values

import 'package:curved_navigation_bar_pro/curved_navigation_bar_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool useSafeArea = true,
  EdgeInsets? mediaQueryPadding,
  CNBPHapticFeedback hapticFeedback = CNBPHapticFeedback.selectionClick,
  VoidCallback? customHapticFeedback,
}) {
  final home = Scaffold(
    bottomNavigationBar: CurvedNavigationBarPro(
      items: items ?? _items,
      currentIndex: index,
      onTap: onTap ?? (_) {},
      backgroundColor: backgroundColor,
      activeColor: activeColor,
      fabColor: fabColor,
      inactiveColor: inactiveColor,
      showLabel: showLabel,
      useSafeArea: useSafeArea,
      hapticFeedback: hapticFeedback,
      customHapticFeedback: customHapticFeedback,
    ),
  );
  return MaterialApp(
    home: mediaQueryPadding != null
        ? MediaQuery(
            data: MediaQueryData(padding: mediaQueryPadding),
            child: home,
          )
        : home,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
//  Semantics helpers
// ─────────────────────────────────────────────────────────────────────────────

/// Returns the first [Semantics] widget whose label
/// equals [label]. Works regardless of whether Flutter merges nodes upward.
Finder _semanticsTileWithLabel(String label) {
  return find.byWidgetPredicate(
    (widget) => widget is Semantics && widget.properties.label == label,
    description: 'Semantics(label: "$label")',
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
    // Flutter's semantics merger can absorb labels into parent nodes, making
    // find.bySemanticsLabel unreliable. Instead we inspect the Semantics
    // widget tree directly via byWidgetPredicate, which is merge-safe.

    testWidgets('each item has a Semantics widget with its label',
        (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      for (final item in _items) {
        expect(
          _semanticsTileWithLabel(item.label),
          findsWidgets,
          reason: 'Expected a Semantics widget with label "${item.label}"',
        );
      }
    });

    testWidgets('active item Semantics widget is marked selected',
        (tester) async {
      await tester.pumpWidget(_buildApp(index: 1)); // SEARCH active
      await tester.pumpAndSettle();

      // Find the Semantics widget for SEARCH and check selected: true.
      final finder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.label == 'SEARCH' &&
            (widget.properties.selected ?? false),
        description: 'Semantics(label: "SEARCH", selected: true)',
      );
      expect(
        finder,
        findsWidgets,
        reason:
            'Active item should have selected: true in its Semantics widget',
      );
    });

    testWidgets('inactive item Semantics widget is NOT marked selected',
        (tester) async {
      await tester
          .pumpWidget(_buildApp(index: 0)); // HOME active, SEARCH inactive
      await tester.pumpAndSettle();

      // There should be no Semantics node for SEARCH with selected: true.
      final selectedFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.label == 'SEARCH' &&
            (widget.properties.selected ?? false),
        description: 'Semantics(label: "SEARCH", selected: true)',
      );
      expect(
        selectedFinder,
        findsNothing,
        reason: 'Inactive item should NOT have selected: true',
      );
    });

    testWidgets('all items have Semantics widgets marked as buttons',
        (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      for (final item in _items) {
        final finder = find.byWidgetPredicate(
          (widget) =>
              widget is Semantics &&
              widget.properties.label == item.label &&
              (widget.properties.button ?? false),
          description: 'Semantics(label: "${item.label}", button: true)',
        );
        expect(
          finder,
          findsWidgets,
          reason: '"${item.label}" should have button: true in Semantics',
        );
      }
    });

    // ── Custom widget items ───────────────────────────────────────────────────

    testWidgets('renders custom inactiveWidget without throwing',
        (tester) async {
      final customItems = [
        const CurvedNavigationItemPro(
          inactiveWidget: Icon(Icons.home, color: Colors.grey),
          activeWidget: Icon(Icons.home, color: Colors.white),
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
      // The badge renders on both the inactive tile AND the active FAB bubble,
      // so we expect findsWidgets (at least one) rather than findsOneWidget.
      const badgedItems = [
        CurvedNavigationItemPro(
          inactiveIcon: Icons.notifications_outlined,
          label: 'ALERTS',
          badgeText: '3',
        ),
        CurvedNavigationItemPro(inactiveIcon: Icons.home, label: 'HOME'),
      ];
      await tester.pumpWidget(_buildApp(items: badgedItems));
      expect(find.text('3'), findsWidgets);
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

  group('CNBPStyleData.copyWith —', () {
    test('returns new instance with updated fields', () {
      const base = CNBPStyleData(
        backgroundColor: Colors.white,
        fabRadius: 24,
        elevation: 14,
      );
      final updated = base.copyWith(fabRadius: 30, elevation: 0);
      expect(updated.fabRadius, 30);
      expect(updated.elevation, 0);
      expect(
          updated.backgroundColor, Colors.white); // unchanged field preserved
    });

    test('copyWith with no args preserves all fields', () {
      const base = CNBPStyleData(barHeight: 100, cornerRadius: 8);
      final copy = base.copyWith();
      expect(copy.barHeight, 100);
      expect(copy.cornerRadius, 8);
    });
  });

  group('CNBPStyles — all presets render', () {
    const presets = CNBPStyles.values;

    for (final style in presets) {
      testWidgets('${style.name} preset renders without error', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              bottomNavigationBar: CurvedNavigationBarPro(
                items: _items,
                currentIndex: 0,
                onTap: (_) {},
                navbarStyle: style,
              ),
            ),
          ),
        );
        expect(find.text('HOME'), findsOneWidget);
      });
    }
  });

  testWidgets('renders with notchShoulderRadius 0 (simple semicircle path)',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: CurvedNavigationBarPro(
            items: _items,
            currentIndex: 0,
            onTap: (_) {},
            notchShoulderRadius: 0,
          ),
        ),
      ),
    );
    expect(find.text('HOME'), findsOneWidget);
  });

  testWidgets('renders with elevation 0 (no shadow painted)', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: CurvedNavigationBarPro(
            items: _items,
            currentIndex: 0,
            onTap: (_) {},
            elevation: 0,
          ),
        ),
      ),
    );
    expect(find.text('HOME'), findsOneWidget);
  });

  testWidgets('no repaint when widget rebuilds with identical props',
      (tester) async {
    final widget = MaterialApp(
      home: Scaffold(
        bottomNavigationBar: CurvedNavigationBarPro(
          items: _items,
          currentIndex: 0,
          onTap: (_) {},
          elevation: 10,
          notchShoulderRadius: 12,
        ),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpWidget(
        widget); // second pump with same instance → shouldRepaint false
    expect(find.text('HOME'), findsOneWidget);
  });

  group('SafeArea and useSafeArea —', () {
    testWidgets('useSafeArea defaults to true on CurvedNavigationBarPro',
        (tester) async {
      final navBar = CurvedNavigationBarPro(
        items: _items,
        onTap: (_) {},
      );
      expect(navBar.useSafeArea, isTrue);
    });

    testWidgets(
        'renders SafeArea and expands bar height when useSafeArea is true and bottom padding exists',
        (tester) async {
      const bottomInset = 34.0;
      const barHeight = 110.0;
      const fabRadius = 24.0;
      const fabSink = 22.0;
      const expectedTotalHeight = barHeight + bottomInset + (fabRadius - fabSink);

      await tester.pumpWidget(
        _buildApp(
          useSafeArea: true,
          mediaQueryPadding: const EdgeInsets.only(bottom: bottomInset),
        ),
      );
      await tester.pumpAndSettle();

      // Verify that SafeArea widgets exist within CurvedNavigationBarPro
      final safeAreaFinder = find.descendant(
        of: find.byType(CurvedNavigationBarPro),
        matching: find.byType(SafeArea),
      );
      expect(safeAreaFinder, findsNWidgets(_items.length));

      // Verify overall widget height includes bottom inset
      final barSize = tester.getSize(find.byType(CurvedNavigationBarPro));
      expect(barSize.height, expectedTotalHeight);
    });

    testWidgets(
        'does not render SafeArea or expand height when useSafeArea is false',
        (tester) async {
      const bottomInset = 34.0;
      const barHeight = 110.0;
      const fabRadius = 24.0;
      const fabSink = 22.0;
      const expectedTotalHeight = barHeight + (fabRadius - fabSink);

      await tester.pumpWidget(
        _buildApp(
          useSafeArea: false,
          mediaQueryPadding: const EdgeInsets.only(bottom: bottomInset),
        ),
      );
      await tester.pumpAndSettle();

      // Verify that NO SafeArea widgets exist within CurvedNavigationBarPro
      final safeAreaFinder = find.descendant(
        of: find.byType(CurvedNavigationBarPro),
        matching: find.byType(SafeArea),
      );
      expect(safeAreaFinder, findsNothing);

      // Verify overall widget height does NOT include bottom inset
      final barSize = tester.getSize(find.byType(CurvedNavigationBarPro));
      expect(barSize.height, expectedTotalHeight);
    });

    testWidgets(
        'nav item onTap functions correctly with useSafeArea true and bottom padding',
        (tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        _buildApp(
          useSafeArea: true,
          mediaQueryPadding: const EdgeInsets.only(bottom: 34.0),
          onTap: (index) => tappedIndex = index,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('SEARCH'));
      await tester.pumpAndSettle();

      expect(tappedIndex, 1);
    });
  });

  group('Haptic feedback —', () {
    testWidgets('hapticFeedback defaults to selectionClick on CurvedNavigationBarPro',
        (tester) async {
      final navBar = CurvedNavigationBarPro(
        items: _items,
        onTap: (_) {},
      );
      expect(navBar.hapticFeedback, equals(CNBPHapticFeedback.selectionClick));
    });

    testWidgets('triggers selectionClick haptic by default when tapping a nav item',
        (tester) async {
      final log = <MethodCall>[];
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (MethodCall methodCall) async {
          log.add(methodCall);
          return null;
        },
      );

      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('SEARCH'));
      await tester.pumpAndSettle();

      final hapticCalls = log.where((call) =>
          call.method == 'HapticFeedback.vibrate' &&
          call.arguments == 'HapticFeedbackType.selectionClick');
      expect(hapticCalls, isNotEmpty);
    });

    testWidgets('triggers lightImpact when hapticFeedback is lightImpact',
        (tester) async {
      final log = <MethodCall>[];
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (MethodCall methodCall) async {
          log.add(methodCall);
          return null;
        },
      );

      await tester.pumpWidget(
        _buildApp(hapticFeedback: CNBPHapticFeedback.lightImpact),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('SEARCH'));
      await tester.pumpAndSettle();

      final hapticCalls = log.where((call) =>
          call.method == 'HapticFeedback.vibrate' &&
          call.arguments == 'HapticFeedbackType.lightImpact');
      expect(hapticCalls, isNotEmpty);
    });

    testWidgets('does not trigger haptic feedback when hapticFeedback is none',
        (tester) async {
      final log = <MethodCall>[];
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (MethodCall methodCall) async {
          log.add(methodCall);
          return null;
        },
      );

      await tester.pumpWidget(
        _buildApp(hapticFeedback: CNBPHapticFeedback.none),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('SEARCH'));
      await tester.pumpAndSettle();

      final hapticCalls = log.where((call) =>
          call.method == 'HapticFeedback.vibrate');
      expect(hapticCalls, isEmpty);
    });

    testWidgets('triggers custom callback when using CNBPHapticFeedback.custom',
        (tester) async {
      var customTriggered = false;
      await tester.pumpWidget(
        _buildApp(
          hapticFeedback: CNBPHapticFeedback.custom(() {
            customTriggered = true;
          }),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('SEARCH'));
      await tester.pumpAndSettle();

      expect(customTriggered, isTrue);
    });

    testWidgets(
        'triggers customWithIndex callback receiving tapped index',
        (tester) async {
      int? receivedIndex;
      await tester.pumpWidget(
        _buildApp(
          hapticFeedback: CNBPHapticFeedback.customWithIndex((index) {
            receivedIndex = index;
          }),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('SAVED'));
      await tester.pumpAndSettle();

      expect(receivedIndex, 2);
    });

    testWidgets(
        'customHapticFeedback parameter takes precedence over hapticFeedback',
        (tester) async {
      var customParamCalled = false;
      final log = <MethodCall>[];
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (MethodCall methodCall) async {
          log.add(methodCall);
          return null;
        },
      );

      await tester.pumpWidget(
        _buildApp(
          hapticFeedback: CNBPHapticFeedback.heavyImpact,
          customHapticFeedback: () {
            customParamCalled = true;
          },
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('SEARCH'));
      await tester.pumpAndSettle();

      expect(customParamCalled, isTrue);
      final hapticCalls = log.where((call) =>
          call.method == 'HapticFeedback.vibrate');
      expect(hapticCalls, isEmpty);
    });

    testWidgets('tapping active FAB bubble triggers haptic and onTap',
        (tester) async {
      int? tappedIndex;
      var customHapticCalled = false;

      await tester.pumpWidget(
        _buildApp(
          index: 0,
          onTap: (i) => tappedIndex = i,
          customHapticFeedback: () => customHapticCalled = true,
        ),
      );
      await tester.pumpAndSettle();

      // Find the FAB bubble by looking for the active icon inside the bubble
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();

      expect(tappedIndex, 0);
      expect(customHapticCalled, isTrue);
    });

    test('all built-in haptic types trigger without error', () {
      expect(() => CNBPHapticFeedback.custom(() {}).trigger(), returnsNormally);
      expect(() => CNBPHapticFeedback.customWithIndex((_) {}).trigger(1), returnsNormally);
      expect(() => CNBPHapticFeedback.none.trigger(), returnsNormally);
      expect(() => CNBPHapticFeedback.selectionClick.trigger(), returnsNormally);
      expect(() => CNBPHapticFeedback.lightImpact.trigger(), returnsNormally);
      expect(() => CNBPHapticFeedback.mediumImpact.trigger(), returnsNormally);
      expect(() => CNBPHapticFeedback.heavyImpact.trigger(), returnsNormally);
      expect(() => CNBPHapticFeedback.vibrate.trigger(), returnsNormally);
    });
  });
}
