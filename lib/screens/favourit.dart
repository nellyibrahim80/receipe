import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:receipe/widgets/recommended.dart';

import '../models/recipe.dart';

class FavouritesPage extends StatefulWidget {
  String collectionName;
 String whereCriteria;
  dynamic? condition;
  FavouritesPage({super.key, required this.collectionName,this.condition,required this.whereCriteria});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(widget.collectionName)
              .where(widget.whereCriteria,
               arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshots.hasError) {
                return const Text('---Stream snapshots.hasError----');
              } else {
                if (snapshots.hasData) {
                  List<Recipes> recipesList = snapshots.data?.docs
                          .map((e) => Recipes.fromJson(e.data(), e.id))
                          .toList() ??
                      [];
                        return (recipesList.isEmpty) 
                        ? (widget.whereCriteria == "recently_viewd_users_ids") ? Text('No Viewed Recipes yet'): Text("You don't have favourite receipes yet ")
                        :  DisplayRecipes(
                      recent: (widget.whereCriteria == "recently_viewd_users_ids") ? "recent": null,
                    recipeList: recipesList,
                  );
                
                } else {
                  return const Text('No Data Found');
                }
              }
            }
          });
  }
}
