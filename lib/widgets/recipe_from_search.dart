import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:receipe/models/recipe.dart';
import 'package:receipe/providers/recipe_fire_provider.dart';

import 'package:receipe/widgets/recommended.dart';


class RecipeFromSearch extends StatefulWidget {
   final List<Recipes> Targetrecipe;
   Map<String,dynamic>? condition;
   
   RecipeFromSearch({super.key, required this.Targetrecipe,this.condition});
 
  @override
  State<RecipeFromSearch> createState() => _RecipeFromSearchState();
}

class _RecipeFromSearchState extends State<RecipeFromSearch> {
    void initState() {
    // TODO: implement initState
 Provider.of<RecipeFireProvider>(context, listen: false).getDefinedRecipes("recipes", "search", widget.condition,widget.Targetrecipe);

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
     
    return Consumer<RecipeFireProvider>(
          builder: (context, recProValue, _) {
            return Column(
              children: [
               
               
                recProValue.displayRecipes == null
                    ? const CircularProgressIndicator()
                    : (recProValue.displayRecipes?.isEmpty ?? false)
                        ? const Text('No Recipes Found')
                        : DisplayRecipes(
                            recipeList: recProValue.displayRecipes,
                          )
              ],
            );
        },
        );
          
  }
}