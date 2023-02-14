import 'package:flutter/material.dart';
import 'package:projet_flutter/page/home_page.dart';
import 'package:projet_flutter/page/profile_page.dart';
import 'package:projet_flutter/page/search_page.dart';
import '/globals.dart' as globals;

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    SearchPage(),
    ProfilePage(userId: globals.user!.id),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onClicked,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onClicked(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }
}
