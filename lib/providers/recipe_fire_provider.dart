import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';

import '../models/recipe.dart';
import '../utilities/toest_message_status.dart';
import '../widgets/ToastMessage.dart';

class RecipeFireProvider extends ChangeNotifier {
  List<Recipes> recipeList = [];
  List<Recipes>? _freshRecipesList=[];
  List<Recipes>? get freshRecipesList => _freshRecipesList;
  List<Recipes>? _recommendedRecipesList=[];
  List<Recipes>? get recommendedRecipesList => _recommendedRecipesList;

  Future<void> getDBRecipe() async {
    try {
      var recipeDBinstance =
          await FirebaseFirestore.instance.collection("recipes").get();
      if (recipeDBinstance.docs.isNotEmpty) {
        recipeList = List<Recipes>.from(
            recipeDBinstance.docs.map((e) => Recipes.fromJson(e.data(), e.id)));
      }
    } catch (e) {
      print("----getDBRecipe Error----$e");
    }

    notifyListeners();
  }

  Future<void> getFreshRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('is_fresh', isEqualTo: true)
          .limit(5)
          .get();

      if (result.docs.isNotEmpty) {
        _freshRecipesList = List<Recipes>.from(
            result.docs.map((doc) => Recipes.fromJson(doc.data(), doc.id)));
      } else {
        _freshRecipesList = [];
      }
      notifyListeners();
    } catch (e) {
      _freshRecipesList = [];
      notifyListeners();
    }
  }

  Future<void> getRecommandedRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('is_fresh', isEqualTo: false)
          .limit(5)
          .get();
      print(result.docs);
      if (result.docs.isNotEmpty) {
        _recommendedRecipesList = List<Recipes>.from(
            result.docs.map((doc) => Recipes.fromJson(doc.data(), doc.id)));
      } else {
        _recommendedRecipesList = [];
      }
      notifyListeners();
    } catch (e) {
      print("error in recomended list $e");
      _recommendedRecipesList = [];
      notifyListeners();
    }
  }

  void addRecipeToUserRecentlyViewed(String recipeId) async {
    try {
      await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .update({
        "recently_viewd_users_ids":
            FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
      });
    } catch (e) {}
  }

  void removeRecipeToUserRecentlyViewed(String recipeId) async {
    try {
      await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .update({
        "recently_viewd_users_ids":
            FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
      });
    } catch (e) {
      print("error $e");
    }
  }

  Future<void> updateRecipe(String recipeId) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .get();
      Recipes? updatedRecipe;
      if (result.data() != null) {
        updatedRecipe = Recipes.fromJson(result.data()!, result.id);
      } else {
        return;
      }
      var recipesListIndex =
      recipeList?.indexWhere((recipe) => recipe.id == recipeId);

      if (recipesListIndex != -1) {
        recipeList?.removeAt(recipesListIndex!);
        recipeList?.insert(recipesListIndex!, updatedRecipe);
      }

      var freshRecipesListIndex =
      freshRecipesList?.indexWhere((recipe) => recipe.id == recipeId);

      if (freshRecipesListIndex != -1) {
        freshRecipesList?.removeAt(freshRecipesListIndex!);
        freshRecipesList?.insert(freshRecipesListIndex!, updatedRecipe);
      }

      var recIndex = recommendedRecipesList
          ?.indexWhere((recipe) => recipe.id == recipeId);

      if (recIndex != -1) {
        recommendedRecipesList?.removeAt(recIndex!);
        recommendedRecipesList?.insert(
            recIndex!, updatedRecipe);
      }

      notifyListeners();
    } catch (e) {
      print('$e>>>>>error in update recipe');
    }
  }

  Future<void> addRecipeToFavourite(String recipeId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "favourite_users_ids":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
        print("added to favourit");
      } else {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "favourite_users_ids":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
        print("removed from favourit");
      }
      await updateRecipe(recipeId);
      OverlayLoadingProgress.stop();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: ToastMessageWidget(
          message: 'Error : ${e.toString()}',
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
    }
  }
}
