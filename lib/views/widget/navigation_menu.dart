import 'package:flutter/material.dart';
import 'package:let_me_cook/views/pages/home_page.dart';
import 'package:let_me_cook/views/pages/favorites_page.dart';
import "../pages/search_page.dart";

class NavigationMenuWidget extends StatefulWidget {
  const NavigationMenuWidget({super.key});

  @override
  _NavigationMenuWidgetState createState() => _NavigationMenuWidgetState();
}

class _NavigationMenuWidgetState extends State<NavigationMenuWidget> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();

    _screens.addAll([
      const HomePage(),
      const FavoritesPage(),
      const SearchPage()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
