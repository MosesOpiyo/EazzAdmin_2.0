import 'package:flutter/material.dart';

class BottomeNavigationBarWidget extends StatefulWidget {
  const BottomeNavigationBarWidget({super.key});

  @override
  State<BottomeNavigationBarWidget> createState() =>
      _BottomeNavigationBarWidgetState();
}

class _BottomeNavigationBarWidgetState
    extends State<BottomeNavigationBarWidget> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Account')
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.deepOrange,
      onTap: _onItemTapped,
    );
  }
}
