import 'package:flutter/material.dart';
import 'package:meals_app/screens/drawer_screen.dart';

class FilterScreen extends StatefulWidget {
  final Map<String, bool> currentFilters;
  final Function saveFilter;

  const FilterScreen(this.currentFilters, this.saveFilter, {super.key});

  static const filterScreen = '/filter-screen';

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetrain = false;
  bool _vegan = false;
  bool _lactoseFree = false;
  
  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _vegetrain = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        actions: [
          IconButton(
            onPressed: () {
              final selectFilter = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetrain,
              };
              widget.saveFilter(selectFilter);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      drawer: const DrawerScreen(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                switchBuild(
                  context,
                  "Gluten-Free",
                  "only include gluten-free meals",
                  _glutenFree,
                  (value) {
                    setState(() {
                      _glutenFree = value;
                    });
                  },
                ),
                switchBuild(
                  context,
                  "Lactose-Free",
                  "only include lactose-free meals",
                  _lactoseFree,
                  (value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                  },
                ),
                switchBuild(
                  context,
                  "Vegetarin",
                  "only include vegetrain meals",
                  _vegetrain,
                  (value) {
                    setState(() {
                      _vegetrain = value;
                    });
                  },
                ),
                switchBuild(
                  context,
                  "Vegan",
                  "only include vegan meals",
                  _vegan,
                  (value) {
                    setState(() {
                      _vegan = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SwitchListTile switchBuild(BuildContext context, String text, String text2,
      bool value, Function(bool) updateValue) {
    return SwitchListTile(
        title: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(text2, style: Theme.of(context).textTheme.bodyLarge),
        value: value,
        onChanged: updateValue);
  }
}
