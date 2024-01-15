import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:receipe/models/recipe.dart';

import '../models/advs.dart';

class AdvProvider extends ChangeNotifier {
  List<Advs> advList = [];
  List<Recipes> RecipeList = [];

  Future<String> LoadJsonFile() async {
    return await rootBundle.loadString("assets/data/data.json");
  }

  Future<List<Map<String, dynamic>>> DecodeJsonData(model) async {
    return List<Map<String, dynamic>>.from(
        jsonDecode(await LoadJsonFile() as String)[model]);
  }

  void advFromJson() async {
    // var adsData2 = await rootBundle.loadString("assets/data/data.json");
    // var decodedData =
    // List<Map<String, dynamic>>.from(jsonDecode(adsData2)["ads"]);
    var decodedData = await DecodeJsonData("ads");
    advList = decodedData.map((e) => Advs.fromJson(e)).toList();
    print("----------------$advList");
    notifyListeners();
  }

  void recipesFromJson() async {
    var decodedData2 = await DecodeJsonData("recipes");
    RecipeList = decodedData2.map((e) => Recipes.fromJson(e)).toList();
    print("[[[[[[[[[[[[[[[[[[$RecipeList");
    notifyListeners();
  }
}
