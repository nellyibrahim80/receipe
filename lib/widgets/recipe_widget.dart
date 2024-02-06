import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe/widgets/recipe_details.dart';

import '../models/recipe.dart';
import '../providers/recipe_fire_provider.dart';
import '../utilities/abstract_colors.dart';

class RecipeWidget extends StatefulWidget {
  var index;
  final Recipes recipe;
  RecipeWidget({required this.index, super.key, required this.recipe});

  @override
  State<RecipeWidget> createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                  onTap: () {
                    Provider.of<RecipeFireProvider>(context, listen: false)
                        .addRecipeToFavourite(
                            widget.recipe!.id!,
                            !(widget.recipe?.favourite_users_ids?.contains(
                                    FirebaseAuth.instance.currentUser?.uid) ??
                                false));
                  },
                  child: (widget.recipe?.favourite_users_ids?.contains(
                              FirebaseAuth.instance.currentUser?.uid) ??
                          false
                      ? const Icon(
                          Icons.favorite_rounded,
                          size: 30,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border_rounded,
                          size: 30,
                          color: Colors.grey,
                        ))),
            ),
            Container(
              width: 90,
              height: 80,
              child: OverflowBox(
                alignment: FractionalOffset.topLeft,
                maxWidth: 130,
                child: Image.asset(
                  "assets/images/${widget.recipe.image}",
                  width: 200, // Ensure that this value does not exceed maxWidth
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
