import 'package:flutter/material.dart';
import 'package:receipe/screens/recipe_full_description.dart';
import 'package:receipe/widgets/favourite_icon.dart';
import 'package:receipe/widgets/recipe_details.dart';

import '../models/recipe.dart';
import '../utilities/abstract_colors.dart';

class DisplayRecipes extends StatelessWidget {
  final List<Recipes> recipeList;
  const DisplayRecipes({super.key, required this.recipeList});

  @override
  Widget build(BuildContext context) {
    // Recipes recipe=recipeList[];
    return

      SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            ...List.generate(recipeList!.length, (index) {
              Recipes recipe=recipeList![index];
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: InkWell(
              onTap: (){  Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>RecipesDesciption(recipe: recipe) ));},
              child: Card(
                color: Color(ConstColors.bgInput),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              
                margin: EdgeInsets.all(0),
                elevation: 0,
                child: ListTile(
                  minVerticalPadding:10,
                  horizontalTitleGap: 0,
                  minLeadingWidth: 90,
                  titleAlignment: ListTileTitleAlignment.top,
                  contentPadding: EdgeInsets.all(0),
                  leading: Container(
                    //color: Colors.red,
                    child: Image.asset(
                      "assets/images/${recipe?.image}",
                      width: 110, // Ensure that this value does not exceed maxWidth
              
                      //fit: BoxFit.cover,
                    ),
                  ),title: RecipeDetails( recipe: recipe,),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       FavouriteIconWidget(recipe:recipe),
                    ],
                  ),),
              ),
            ),
          );
        }
                ,)

          ],
        ),
      );
  }
}
