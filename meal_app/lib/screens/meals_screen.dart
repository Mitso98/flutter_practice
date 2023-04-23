import 'package:flutter/material.dart';

import '../models/dummy_data.dart';
import '../widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  // final String id;
  // final String title;

  static const routeName = "/meals-screen";

  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    final categoryTitle = routeArgs["title"];
    final categoryID = routeArgs["id"];

    final meal = DUMMY_MEALS.where((elm) {
      return elm.categories.contains(categoryID);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            affordability: meal[index].affordability,
            complexity: meal[index].complexity,
            duration: meal[index].duration,
            imageUrl: meal[index].imageUrl,
            title: meal[index].title,
            id: meal[index].id,
          );
        },
        itemCount: meal.length,
      ),
    );
  }
}
