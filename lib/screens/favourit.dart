import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';

import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../widgets/recipe_widget.dart';


class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites page'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('recipes')
              .where("favourite_users_ids",
              arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshots.hasError) {
                return const Text('ERROR WHEN GET DATA');
              } else {
                if (snapshots.hasData) {
                  List<Recipes> recipesList = snapshots.data?.docs
                      .map((e) => Recipes.fromJson(e.data(), e.id))
                      .toList() ??
                      [];
                  return FlexibleGridView(
                    children: recipesList
                        .map((e) => RecipeWidget(recipe: e, index: null,))
                        .toList(),
                    axisCount: GridLayoutEnum.twoElementsInRow,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  );
                } else {
                  return const Text('No Data Found');
                }
              }
            }
          }),
    );
  }
}