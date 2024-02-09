
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe/models/recipe.dart';
import 'package:receipe/providers/ingredient_provider.dart';
import 'package:receipe/providers/recipe_fire_provider.dart';
import 'package:receipe/utilities/abstract_colors.dart';
import 'package:receipe/widgets/BlackTitle.dart';
import 'package:receipe/widgets/favourite_icon.dart';
import 'package:receipe/widgets/grey_small_icons.dart';
import 'package:receipe/widgets/ingredient_list.dart';
import 'package:receipe/widgets/rate_stars.dart';


// ignore: must_be_immutable
class RecipesDesciption extends StatefulWidget {
  Recipes recipe;
  RecipesDesciption({super.key, required this.recipe});

  @override
  State<RecipesDesciption> createState() => _RecipesDesciptionState();
}

class _RecipesDesciptionState extends State<RecipesDesciption> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<RecipeFireProvider>(context, listen: false).getDefinedRecipes(
        "recipes",
        "recipeID",
        widget.recipe.id,
        Provider.of<RecipeFireProvider>(context, listen: false).displayRecipes);
    Provider.of<IngredientFireProvider>(context, listen: false).getIngredient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeFireProvider>(builder: (context, recProvider, child) {
      
      
     // Recipes refRecipe = recProvider.displayRecipes.first;
      return Scaffold(
                        
        appBar: AppBar(),
        body: recProvider.displayRecipes == null
                  ? const CircularProgressIndicator()
                  : (recProvider.displayRecipes.isEmpty ?? false)
                      ? const Text('No Recipe Found')
                      :Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Column( 
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [ 
                                      Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.recipe.MealType.toString(),
                                      style: TextStyle(
                                          color: Color(ConstColors.textCyanInput),
                                          fontSize:18),
                                    ),
                                  ],
                                ),
                                  Row(
                                    children: [
                                     
                                      SizedBox(
                                        width: 350,
                                        child: HeaderBlack(
                                            HeaderBlackTitle: widget.recipe!.title.toString()),
                                      ),
                                      FavouriteIconWidget(recipe: recProvider.displayRecipes.first),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${widget.recipe?.calories} Calories',
                              style: const TextStyle(
                                  color: Color(ConstColors.titleColors),
                                  fontSize: 10)),
                        ],
                                            ),
                                            Padding(
                          padding: EdgeInsets.all(5),
                          child: StarsRate(
                              recipeRate: widget.recipe.rate != null
                                  ? widget.recipe?.rate!.toDouble() ?? 0
                                  : 5)),
                                            SmallGrey(
                        txt: 'min',
                        usedIcon: Icons.access_time_rounded,
                        usedValue: ' ${widget.recipe?.prepare}',
                                            ),
                                            SizedBox(
                        width: 15,
                                            ),
                                            SmallGrey(
                        txt: 'ٍserving',
                        usedIcon: Icons.room_service_outlined,
                        usedValue: ' ${widget.recipe.serving}',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        //color: Colors.red,
                                        child: Image.asset(
                                          "assets/images/${widget.recipe?.image}",
                                          width: 250, // Ensure that this value does not exceed maxWidth
                        
                                          //fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IngredientList(),
                                ]),
                      ),
      );
    });
  }
}
