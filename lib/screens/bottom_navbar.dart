


import 'package:flutter/material.dart';
import 'package:rest_api/screens/card_screen.dart';
import 'package:rest_api/screens/favorite_screen.dart';
import 'package:rest_api/screens/home_screen.dart';
import 'package:rest_api/screens/profile.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  BottomNavbarState createState() => BottomNavbarState();
}

class BottomNavbarState extends State<BottomNavbar> {
  // Index to track which tab is selected
  int _selectedIndex = 0;

  // Screens for each tab
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    const FavoriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  // Titles for each tab
  static final List<String> _titles = [
    'Home',
    'Favorites',
    'Cart',
    'Profile',
  ];

  // Function to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]), // Dynamic title change
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Active color
        unselectedItemColor: Colors.grey, // Inactive color
        onTap: _onItemTapped, // Handle tab tap
      ),
    );
  }
}
