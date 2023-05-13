import 'package:flutter/material.dart';
import '../dummy-data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  Function toggleFavorite;
  Function isMealFavorite;
  MealDetailScreen(this.toggleFavorite, this.isMealFavorite);
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      height: 130,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealsId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere(
      (meal) {
        return meal.id == mealsId;
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text('Детали блюда ${selectedMeal.name}')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ингредиенты'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(selectedMeal.ingredients[index])),
                ),
              ),
            ),
            buildSectionTitle(context, 'Шаги'),
            buildContainer(
              ListView.builder(
                itemBuilder: ((ctx, index) => ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    )),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isMealFavorite(mealsId)
              ? Icons.favorite
              : Icons.favorite_border_outlined,
        ),
        onPressed: () => toggleFavorite(mealsId),
      ),
    );
  }
}
