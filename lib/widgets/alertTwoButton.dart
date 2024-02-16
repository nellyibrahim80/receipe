import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe/providers/recipe_fire_provider.dart';




class confirm extends StatelessWidget {
  var Taskindex;

  confirm({this.Taskindex, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeFireProvider>(builder: (context, viewModel, child) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        title: Row(
          children: [
            const Icon(
              Icons.dangerous_outlined,
              color: Colors.red,
              size: 40,

            ),
            Text(
              " Delete Task",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        content: Text(
            'Are You Sure You Want To Delete from recently viewed?'),
        actions: [
          TextButton(
            child: const Text("Yes",
                style: TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            onPressed: () {
              Provider.of<RecipeFireProvider>(context,
                                      listen: false)
                                  .addRecipeToFavourite(
                                      "recently_viewd_users_ids",
                                      viewModel.displayRecipes[Taskindex].id!,
                                      false);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("No",
                style: TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}
