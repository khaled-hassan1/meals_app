import 'package:flutter/material.dart';

// import '../screens/favorite_screen.dart';
import './dummy_data.dart';
import './models/meals_model.dart';
import './screens/filter_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/tabs_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Meal> _favoriteMeals = [];
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeal = DUMMY_MEALS;
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeal = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _togglefavorite(String mealId) {
    final existingmeal =
        _favoriteMeals.indexWhere((element) => element.id == mealId);
    if (existingmeal >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingmeal);
      });
    } else {
      setState(() {
        _favoriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isFavoriteMeal(String id) {
    return _favoriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white24,
          primary: Colors.orangeAccent,
          secondary: Colors.orange.shade900,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.black,
            // fontFamily: 'PTSerif',
            fontWeight: FontWeight.bold,
          ),
        ),
        fontFamily: 'PTSerif',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeal),
        MealDetailScreen.routeDetail: (context) =>
            MealDetailScreen(_isFavoriteMeal,_togglefavorite),
        FilterScreen.filterScreen: (context) =>
            FilterScreen(_filters, _setFilters),
            // FavoriteScreen.favoriteScreen:(context) =>  FavoriteScreen(),
      },
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(
      //     builder: (context) => const CategotiesScreen(),
      //   );
      // },
    );
  }
}
