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
    Provider.of<IngredientFireProvider>(context, listen: false)
        .getIngredient('user_ids');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeFireProvider>(builder: (context, recProvider, child) {
      Divider line= Divider(color:Color.fromARGB(255, 227, 227, 227),);
      // Recipes refRecipe = recProvider.displayRecipes.first;
      return Scaffold(
        appBar: AppBar(),
        body: recProvider.displayRecipes == null
            ? const CircularProgressIndicator()
            : (recProvider.displayRecipes.isEmpty ?? false)
                ? const Text('No Recipe Found')
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(21.0),
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
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 315,
                                  child: HeaderBlack(
                                      HeaderBlackTitle:
                                          widget.recipe!.title.toString()),
                                ),
                                FavouriteIconWidget(
                                    recipe: recProvider.displayRecipes.first),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${widget.recipe?.calories} Calories',
                                            style: const TextStyle(
                                                color: Color(
                                                    ConstColors.titleColors),
                                                fontSize: 15)),
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 10, top: 10),
                                        child: StarsRate(
                                            recipeRate:
                                                widget.recipe.rate != null
                                                    ? widget.recipe.rate!
                                                            .toDouble() ??
                                                        0
                                                    : 5)),
                                   
                                    SizedBox(
                                      height: 25,
                                    ),
                                    SmallGrey(
                                      txt: 'min',
                                      usedIcon: Icons.access_time_rounded,
                                      usedValue: ' ${widget.recipe.prepare}',
                                      txtSize: 17,
                                    ),
                                   
                                    Padding(
                                      padding: const EdgeInsets.only(top:28.0,bottom: 30),
                                      child: SmallGrey(
                                        txt: 'ٍserving',
                                        usedIcon: Icons.room_service_outlined,
                                        usedValue: ' ${widget.recipe.serving}',
                                        txtSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                 padding: const EdgeInsets.only(top:20.0,bottom: 30),
                                  child: Image.asset(
                                    "assets/images/${widget.recipe?.image}",
                                    width:
                                        210, // Ensure that this value does not exceed maxWidth
                                                              
                                    //fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            line,
                               
                            IngredientList(
                                recipeIngredientList:
                                    recProvider.openedRecipe!.ingredient ?? []),
                                    line,
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: const Row(
                                children: [
                                  Text(
                                    "Directions",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children:
                                  widget.recipe.direction!.entries.map((entry) {
                                int? keyAsInt =
                                    int.tryParse(entry.key.toString());
                                bool isNumeric = keyAsInt is num;
                                return Padding(
                                  //paddin need adjust
                                  padding: const EdgeInsets.only(top:30.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color:
                                                Color(ConstColors.titleColors),
                                            size: 8,
                                          ),
                                          Text(
                                              (isNumeric)
                                                  ? ' Step ${entry.key.toString()}'
                                                  : ' ${entry.key.toString()}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Text(entry.value.toString()),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ]),
                    ),
                  ),
      );
    });
  }
}
