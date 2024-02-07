import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:receipe/models/recipe.dart';
import 'package:receipe/providers/recipe_fire_provider.dart';
import 'package:receipe/widgets/Search.dart';
import 'package:receipe/widgets/recommended.dart';
import 'package:receipe/widgets/sub_header.dart';

class RecipeFromQuery extends StatefulWidget {
   final List<Recipes> Targetrecipe;
   
   RecipeFromQuery({super.key, required this.Targetrecipe});

  @override
  State<RecipeFromQuery> createState() => _RecipeFromQueryState();
}

class _RecipeFromQueryState extends State<RecipeFromQuery> {
    void initState() {
    // TODO: implement initState
 
    Provider.of<RecipeFireProvider>(context, listen: false)
        .getDefinedRecipes("recipes", "all", "", widget.Targetrecipe);
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