import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';

import '../models/recipe.dart';
import '../utilities/toest_message_status.dart';
import '../widgets/ToastMessage.dart';

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
    ////////////////////////////////
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
        } else {
          await FirebaseFirestore.instance
              .collection('recipes')
              .doc(recipeId)
              .update({
            "favourite_users_ids":
            FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
          });
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

    /////////////////////////////
    notifyListeners();
  }
}