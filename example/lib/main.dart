import 'package:flutter/material.dart';
import 'package:curved_navigation_bar_pro/curved_navigation_bar_pro.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CurvedNavBarPro Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  static const _pages = [
    _PageContent(emoji: '🏠', label: 'Home'),
    _PageContent(emoji: '🔍', label: 'Search'),
    _PageContent(emoji: '❤️', label: 'Saved'),
    _PageContent(emoji: '👤', label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('CurvedNavBar Demo'),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_index],
      ),
      bottomNavigationBar: CurvedNavigationBarPro(
        // navbarStyle: CNBPStyles.emeraldPill,
        items: const [
          CurvedNavigationItemPro(
            inactiveIcon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: 'HOME',
          ),
          CurvedNavigationItemPro(
            inactiveIcon: Icons.search_outlined,
            activeIcon: Icons.search_rounded,
            label: 'SEARCH',
          ),
          CurvedNavigationItemPro(
            inactiveIcon: Icons.favorite_outline,
            activeIcon: Icons.favorite_rounded,
            label: 'SAVED',
          ),
          CurvedNavigationItemPro(
            inactiveIcon: Icons.person_outline_rounded,
            activeIcon: Icons.person_rounded,
            label: 'PROFILE',
          ),
        ],
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent({required this.emoji, required this.label});

  final String emoji;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      key: ValueKey(label),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 72)),
          const SizedBox(height: 16),
          Text(
            label,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
