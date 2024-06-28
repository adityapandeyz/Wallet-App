import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persist_wallet_app/screens/home_screen.dart';
import 'package:persist_wallet_app/screens/profile_screen.dart';

/// A screen that displays a bottom navigation bar with two tabs: Wallet and Profile.
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  /// Callback function that is called when a tab is tapped.
  /// It updates the selected index and triggers haptic feedback.
  void _onItemTapped(int index) {
    _selectedIndex = index;
    HapticFeedback.vibrate();

    setState(() {});
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        iconSize: 28,
        unselectedItemColor: const Color.fromARGB(87, 255, 255, 255),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userAlt),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
