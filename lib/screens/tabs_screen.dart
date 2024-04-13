import 'package:flutter/material.dart';
import 'package:meals_app/models/meals_model.dart';

import '/screens/categories_screen.dart';
import '/screens/drawer_screen.dart';
import '/screens/favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const TabsScreen(this.favoriteMeals, {super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>>? _pages;
  int _selected = 0;
  void _onSelected(int value) {
    setState(() {
      _selected = value;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        'page': const CategotiesScreen(),
        'title': 'Categories',
        'action': const Icon(Icons.sailing)
      },
      {
        'page': FavoriteScreen(widget.favoriteMeals),
        'title': 'Favorites',
        'action': const Icon(Icons.face)
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: Text(
          _pages![_selected]['title'],
        ),
        actions: [
          _pages![_selected]['action'],
        ],
      ),
      body: _pages![_selected]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        currentIndex: _selected,
        onTap: _onSelected,
        elevation: 5,
      ),
    );
  }
}
