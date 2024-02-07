import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe/models/recipe.dart';
import 'package:receipe/providers/recipe_fire_provider.dart';

class FavouriteIconWidget extends StatefulWidget {
  Recipes? recipe;
   FavouriteIconWidget({super.key,required this.recipe});

  @override
  State<FavouriteIconWidget> createState() => _FavouriteIconWidgetState();
}

class _FavouriteIconWidgetState extends State<FavouriteIconWidget> {
  @override
  Widget build(BuildContext context) {
    return     Padding(
              padding: const EdgeInsets.all(12.0),
              child:
               InkWell(
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
                          size: 25,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border_rounded,
                          size: 25,
                          color: Colors.grey,
                        ))),
            );
  }
}