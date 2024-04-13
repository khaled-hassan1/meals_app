import 'package:flutter/material.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';

import 'package:meals_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen(this.isFavorite, this.favoriteMeal, {super.key});
  final Function(String) favoriteMeal;
  final Function(String) isFavorite;
  static const routeDetail = '/detail-screen';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedFloatingActionButtonState> key =
        GlobalKey<AnimatedFloatingActionButtonState>();

    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);

    const icon = [
      Icon(Icons.star_border),
      Icon(
        Icons.star,
        size: 30,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(selectMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            titleText(context, 'Ingredients'),
            containerBuild(
              ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.amberAccent.shade400,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        selectMeal.ingredients[index],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  );
                },
                itemCount: selectMeal.ingredients.length,
              ),
            ),
            titleText(context, 'Steps'),
            containerBuild(
              ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${index + 1}'),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            selectMeal.steps[index],
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                    ],
                  );
                },
                itemCount: selectMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        durationAnimation: 160,
        curve: Curves.bounceIn,
        fabButtons: [
          FloatingActionButton(
            heroTag: 'Button1',
            tooltip: 'Favorite1',
            onPressed: () => favoriteMeal(mealId),
            child: isFavorite(mealId) ? icon[1] : icon[0],
          ),
          FloatingActionButton(
            heroTag: 'Button2',
            tooltip: 'Back!',
            child: const Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.of(context).pop(mealId);
              Navigator.of(context).popAndPushNamed('/');
            },
          ),
          // FloatingActionButton(
          //   heroTag: 'Button3',
          //   tooltip: 'Back!',
          //   child: const Icon(Icons.favorite),
          //   onPressed: () {
          //     Navigator.of(context).popAndPushNamed('/favorite-screen');
          //   },
          // ),
        ],
        animatedIconData: AnimatedIcons.menu_home,
        key: key,
        colorStartAnimation: Colors.blue,
        colorEndAnimation: const Color.fromARGB(255, 5, 253, 228),
      ),

      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.delete),
      //   onPressed: () {
      //     Navigator.of(context).pop(mealId);
      //   },
      // ),
    );
  }

  Container containerBuild(Widget child) {
    return Container(
      height: 190,
      width: 300,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }

  Text titleText(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
