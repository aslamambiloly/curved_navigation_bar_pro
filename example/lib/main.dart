import 'package:flutter/material.dart';
import 'package:curved_navigation_bar_pro/curved_navigation_bar_pro.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CurvedNavigationBarPro Demo',
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
    _PageContent(emoji: '🛒', label: 'Cart'),
    _PageContent(emoji: '👤', label: 'Profile'),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('CurvedNavigationBarPro'),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_index],
      ),
      bottomNavigationBar: CurvedNavigationBarPro(
        barHeight: 100,
        cornerRadius: 20,
        activeColor: const Color(0xFF6C63FF),
        inactiveTextStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        activeTextStyle: const TextStyle(
          color: Color(0xFF6C63FF),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
        items: [
          const CurvedNavigationItemPro(
            inactiveIcon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: 'Home',
            badgeText: '3',
          ),
          const CurvedNavigationItemPro(
            inactiveIcon: Icons.search_outlined,
            activeIcon: Icons.search_rounded,
            label: 'Search',
            badgeText: '•',
          ),
          const CurvedNavigationItemPro(
            inactiveIcon: Icons.favorite_border_rounded,
            activeIcon: Icons.favorite_rounded,
            label: 'Saved',
          ),
          CurvedNavigationItemPro(
            inactiveIcon: Icons.shopping_cart_outlined,
            activeIcon: Icons.shopping_cart_rounded,
            activeWidget: Lottie.asset(
              'lotties/cart.json',
              repeat: false,
              width: 28,
            ),
            label: 'Cart',
            badgeColor: Colors.orange[800],
          ),
          
          CurvedNavigationItemPro(
            inactiveIcon: Icons.person_outline_rounded,
            activeIcon: Icons.person_rounded,
            inactiveWidget: SvgPicture.asset(
              'assets/images/call.svg',
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.srcIn,
              ),
              width: 22,
            ),
            activeWidget: SvgPicture.asset(
              'assets/images/call.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 22,
            ),
            label: 'Profile',
            badgeText: 'NEW',
            badgeColor: Colors.teal[600],
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
