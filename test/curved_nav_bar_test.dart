import 'package:curved_navigation_bar_pro/curved_navigation_bar_pro.dart';
import 'package:curved_navigation_bar_pro/src/curved_navigation_bar_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _items = [
  CurvedNavItemPro(
      icon: Icons.home_outlined, activeIcon: Icons.home, label: 'HOME'),
  CurvedNavItemPro(icon: Icons.search, label: 'SEARCH'),
  CurvedNavItemPro(icon: Icons.favorite_outline, label: 'SAVED'),
  CurvedNavItemPro(icon: Icons.person_outline, label: 'PROFILE'),
];

Widget _buildApp({int index = 0, ValueChanged<int>? onTap}) {
  return MaterialApp(
    home: Scaffold(
      bottomNavigationBar: CurvedNavBarPro(
        items: _items,
        currentIndex: index,
        onTap: onTap ?? (_) {},
      ),
    ),
  );
}

void main() {
  group('CurvedNavBarPro', () {
    testWidgets('renders all item labels', (tester) async {
      await tester.pumpWidget(_buildApp());
      for (final item in _items) {
        expect(find.text(item.label), findsOneWidget);
      }
    });

    testWidgets('calls onTap with correct index', (tester) async {
      int? tappedIndex;
      await tester.pumpWidget(_buildApp(onTap: (i) => tappedIndex = i));

      await tester.tap(find.text('SEARCH'));
      await tester.pumpAndSettle();

      expect(tappedIndex, equals(1));
    });

    testWidgets('updates active item when currentIndex changes', (tester) async {
      await tester.pumpWidget(_buildApp(index: 0));
      await tester.pumpWidget(_buildApp(index: 2));
      await tester.pumpAndSettle();
      // No assertion throws ─ animation completes cleanly.
    });

    testWidgets('throws assertion for fewer than 2 items', (tester) async {
      expect(
        () => CurvedNavBarPro(
          items: const [CurvedNavItemPro(icon: Icons.home, label: 'HOME')],
          onTap: (_) {},
        ),
        throwsAssertionError,
      );
    });

    testWidgets('throws assertion for more than 6 items', (tester) async {
      const many = [
        CurvedNavItemPro(icon: Icons.home, label: 'A'),
        CurvedNavItemPro(icon: Icons.home, label: 'B'),
        CurvedNavItemPro(icon: Icons.home, label: 'C'),
        CurvedNavItemPro(icon: Icons.home, label: 'D'),
        CurvedNavItemPro(icon: Icons.home, label: 'E'),
        CurvedNavItemPro(icon: Icons.home, label: 'F'),
        CurvedNavItemPro(icon: Icons.home, label: 'G'),
      ];
      expect(
        () => CurvedNavBarPro(items: many, onTap: (_) {}),
        throwsAssertionError,
      );
    });

    testWidgets('throws assertion for out-of-range currentIndex', (tester) async {
      expect(
        () => CurvedNavBarPro(items: _items, currentIndex: 99, onTap: (_) {}),
        throwsAssertionError,
      );
    });

    testWidgets('accepts custom colors without throwing', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: CurvedNavBarPro(
              items: _items,
              currentIndex: 0,
              onTap: (_) {},
              backgroundColor: Colors.black,
              activeColor: Colors.amber,
              fabColor: Colors.deepOrange,
              inactiveColor: Colors.white54,
            ),
          ),
        ),
      );
      expect(find.text('HOME'), findsOneWidget);
    });

    testWidgets('has accessible semantics labels', (tester) async {
      await tester.pumpWidget(_buildApp());
      expect(find.bySemanticsLabel('HOME'), findsOneWidget);
      expect(find.bySemanticsLabel('SEARCH'), findsOneWidget);
    });
  });
}
