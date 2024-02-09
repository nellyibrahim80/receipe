import 'package:flutter/material.dart';
import 'package:receipe/widgets/BlackTitle.dart';
import 'package:receipe/widgets/grey_small_icons.dart';

import 'package:receipe/widgets/rate_stars.dart';

import '../models/recipe.dart';
import '../utilities/abstract_colors.dart';

class RecipeDetails extends StatelessWidget {
  //final int RecipeIndex;
  final double? starsPadding;
  final Recipes recipe;
  final bool? details;
  const RecipeDetails(
      {this.starsPadding, super.key, required this.recipe, this.details});

  @override
  Widget build(BuildContext context) {
    // Recipes recipe=recipeList[RecipeIndex];
    EdgeInsetsGeometry padding = EdgeInsets.only(
        bottom: starsPadding ?? 0.0, top: starsPadding ?? 0.0, left: 0.0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              recipe.MealType.toString(),
              style: TextStyle(
                  color: Color(ConstColors.textCyanInput),
                  fontSize:12),
            ),
          ],
        ),
        Row(
          children: [
            (details ?? false)
                ? SizedBox(
                    width: 380,
                    child: HeaderBlack(
                      HeaderBlackTitle: recipe!.title.toString(),
                    ))
                : SizedBox(
                    width: 160,
                    child: Text(
                      recipe!.title.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
          ],
        ),
        Padding(
            padding: padding,
            child: StarsRate(
                recipeRate:
                    recipe.rate != null ? recipe?.rate!.toDouble() ?? 0 : 5)),
        Row(
          children: [
            Text('${recipe?.calories} Calories',
                style: const TextStyle(
                    color: Color(ConstColors.titleColors), fontSize: 10)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              SmallGrey(
                txt: 'min',
                usedIcon: Icons.access_time_rounded,
                usedValue: ' ${recipe?.prepare}',
              ),
              SizedBox(
                width: 15,
              ),
              SmallGrey(
                txt: 'ٍserving',
                usedIcon:Icons.room_service_outlined,
                usedValue: ' ${recipe.serving}',
              ),
             
            ],
          ),
        )
      ],
    );
  }
}
