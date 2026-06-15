import 'package:flutter/material.dart';
import 'package:curved_navigation_bar_pro/curved_navigation_bar_pro.dart';
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
        fontFamily: 'sora',
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      bottomNavigationBar: CurvedNavigationBarPro(
        barHeight: 90,
        fabSink: 20,
        fabGap: 8,
        cornerRadius: 17,
        notchShoulderRadius: 17,
        contentPadding: 19,
        navbarStyle: CNBPStyles.minimalMono,
        activeIconSize: 26,
        inactiveIconSize: 26,
        inactiveColor: Colors.grey,
        inactiveTextStyle: TextStyle(
          fontFamily: 'sora'
        ),
        shadowColor: Colors.black.withValues(alpha: 0.1),
        activeTextStyle:
            TextStyle(fontFamily: 'sora', fontWeight: FontWeight.w600
        ),
      
        items: [
          const CurvedNavigationItemPro(
            inactiveIcon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: 'Home',
          ),
          const CurvedNavigationItemPro(
            inactiveIcon: Icons.search_outlined,
            activeIcon: Icons.search_rounded,
            label: 'Search',
            // badgeText: '•',
          ),
          CurvedNavigationItemPro(
              inactiveIcon: Icons.shopping_cart_outlined,
            activeWidget: Lottie.asset(
              'lotties/cart.json',
              repeat: false,
              width: 28,
            ),
            label: 'Cart',
              badgeText: '•'
          ),
          const CurvedNavigationItemPro(
            inactiveIcon: Icons.favorite_border_rounded,
            activeIcon: Icons.favorite_rounded,
            label: 'Favourites',
            badgeText: '7',
          ),
         
          
          CurvedNavigationItemPro(
            inactiveIcon: Icons.person_outline_rounded,
            activeIcon: Icons.person_rounded,
            
            label: 'Profile',
            
          ),
        ],
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

