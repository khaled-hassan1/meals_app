import 'package:flutter/material.dart';

import '../screens/filter_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(20),
            color: Colors.orange,
            child: const Text(
              'Cooking Up!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          listTileBuild(Icons.restaurant, 'Meals', () {
            Navigator.of(context)
                .pushReplacementNamed('/'); //to not back the last screen
          }),
          listTileBuild(
            Icons.settings,
            'Filters',
            () => Navigator.of(context)
                .pushReplacementNamed(FilterScreen.filterScreen),
          ),
        ],
      ),
    );
  }

  ListTile listTileBuild(IconData icon, String text, VoidCallback handler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: handler,
    );
  }
}
