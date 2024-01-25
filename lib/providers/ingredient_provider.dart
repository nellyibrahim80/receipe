import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../models/ingredient.dart';

class IngredientFireProvider extends ChangeNotifier{
  List<Ingredient> ingredientList=[];

  Future<void> getIngredient() async{
    try{
      print("$ingredientList----before-------------------------------");
      var IngredientDbList=await FirebaseFirestore.instance.collection("ingredient").get();
      print("${IngredientDbList.docs}}---------------after--------------------");
      //ingredientList=List<Ingredient>.from(IngredientDbList.docs.map((e) => Ingredient.fromJson(e.data(),e.id)));

      if(IngredientDbList.docs.isNotEmpty){
        ingredientList=List<Ingredient>.from(IngredientDbList.docs.map((e) => Ingredient.fromJson(e.data(),e.id)));
        print(ingredientList);
print("-----------------------------------");
      }
    }
        catch(e){
      print(e);
        }
        notifyListeners();
  }

}