import 'package:flutter/material.dart';

import '../screens/category_meals_screen.dart';

class CategoriesItem extends StatelessWidget {
  const CategoriesItem(
      {super.key, required this.id, required this.color, required this.title});
  final String id;
  final String title;
  final Color color;

  void selectCategory(BuildContext context) {
    Navigator.pushNamed(
      context,
      CategoryMealsScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
