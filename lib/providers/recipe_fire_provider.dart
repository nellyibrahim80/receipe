import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/recipe.dart';

class RecipeFireProvider extends ChangeNotifier {
  List<Recipes> recipeList=[];
  
  Future<void> getDBRecipe() async {
    try {
      var recipeDBinstance = await FirebaseFirestore.instance.collection(
          "recipes")
          .get();
      if (recipeDBinstance.docs.isNotEmpty) {
        recipeList = List<Recipes>.from(
            recipeDBinstance.docs.map((e) => Recipes.fromJson(e.data(), e.id)));
      }
    } catch (e) {
      print("----getDBRecipe Error----$e");
    }
    notifyListeners();
  }
}