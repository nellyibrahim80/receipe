import 'package:flutter/material.dart';
import 'package:receipe/widgets/recipe_details.dart';

import '../models/recipe.dart';
import '../utilities/abstract_colors.dart';

class RecipeWidget extends StatefulWidget {
  var index;
  final Recipes recipe;
   RecipeWidget({required this.index,super.key, required this.recipe});

  @override
  State<RecipeWidget> createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.favorite_border,
              color: Color(ConstColors.textInput),
            ),
            Container(
              width: 90,
              height: 80,
              child: OverflowBox(
                alignment: FractionalOffset.topLeft,
                maxWidth: 130,
                child: Image.asset(
                  "assets/images/${widget.recipe.image}",
                  width:
                  200, // Ensure that this value does not exceed maxWidth
                  height: 80,
                  //fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
        RecipeDetails(

          starsPadding: 6,
          recipe: widget.recipe,
        )
      ],
    );
  }
}
