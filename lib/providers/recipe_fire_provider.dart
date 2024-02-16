import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';

import '../models/recipe.dart';
import '../utilities/toest_message_status.dart';
import '../widgets/ToastMessage.dart';

class RecipeFireProvider extends ChangeNotifier {
  List<Recipes> recipeList = [];
  List<Recipes> freshRecipesList = [];
  List<Recipes> displayRecipes = [];
    List<Recipes> mealtypeList = [];

  // List<Recipes> _freshRecipesList=[];
  // List<Recipes>? get freshRecipesList => _freshRecipesList;
  List<Recipes> _recommendedRecipesList = [];
  List<Recipes> get recommendedRecipesList => _recommendedRecipesList;
  Recipes? openedRecipe;

  Future<void> getDefinedRecipes(String collectionName, String whereCriteria,
      dynamic condition, List<Recipes> targetList) async {
    dynamic result;
    targetList.clear();
    try {
      OverlayLoadingProgress.start();
      dynamic query;
      QuerySnapshot<Map<String, dynamic>> result;
      var firebaseIns = FirebaseFirestore.instance.collection(collectionName);

      if (whereCriteria == "recipeID") {
        query = await firebaseIns.doc(condition.toString()).get();
        if (query.data() != null) {
          openedRecipe = Recipes.fromJson(query.data()!, query.id);
          targetList.clear();
          targetList.add(openedRecipe!);
          print(targetList);
        } else {
          return;
        }
      } else {
        if (condition != "") {
          if (whereCriteria == "search") {
            for (var entry in condition.entries) {
               query = (entry.key=="calories" || entry.key=="prepare") 
               ?firebaseIns.where(entry.key, isLessThanOrEqualTo: entry.value)
               :firebaseIns.where(entry.key, isEqualTo: entry.value);
            }
          } 
          else if (whereCriteria == "recently_viewd_users_ids"){
            query =firebaseIns.where(whereCriteria,  arrayContains: condition);
          }
          else {
            query =firebaseIns.where(whereCriteria,  isEqualTo: condition);
          }
        }
        (whereCriteria == "all")
            ? result = await firebaseIns.get()
            : result =
                await (query as Query<Map<String, dynamic>>).limit(5).get();

        print(result);

        if (result.docs.isNotEmpty) {
          // targetList = List<Recipes>.from(
          //   result.docs.map((doc) => Recipes.fromJs++on(doc.data(), doc.id)));
          targetList.clear();
          targetList.addAll(
              result.docs.map((doc) => Recipes.fromJson(doc.data(), doc.id)));
          
          print(targetList);
        }
        else{
          targetList.clear();
          OverlayLoadingProgress.stop();
        }
      }
      notifyListeners();
      OverlayLoadingProgress.stop();
    } catch (e) { 
      targetList = [];
      targetList.clear();
      print("error in $targetList ------- $e");
     OverlayLoadingProgress.stop();
      //   notifyListeners();
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
      Recipes updatedRecipe;
      if (result.data() != null) {
        updatedRecipe = Recipes.fromJson(result.data()!, result.id);
      } else {
        return;
      }
      void updatelist(List<Recipes> listToUpdate) {
        var recipesListIndex =
            listToUpdate.indexWhere((recipe) => recipe.id == recipeId);

        if (recipesListIndex != -1) {
          listToUpdate.removeAt(recipesListIndex);
          listToUpdate.insert(recipesListIndex, updatedRecipe);
          print("Done update list for ${listToUpdate}");
        }
      }

      updatelist(recipeList);
      updatelist(freshRecipesList!);
      updatelist(recommendedRecipesList!);
      updatelist(displayRecipes!);
      notifyListeners();

      
    } catch (e) {
      print('$e>>>>>error in update recipe');
    }
  }

  Future<void> addRecipeToFavourite(String feildName, String recipeId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          feildName:
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
        print("added to $feildName");
      } else {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          feildName:
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
        print("removed from $feildName");
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
