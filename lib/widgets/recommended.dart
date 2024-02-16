import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:receipe/providers/recipe_fire_provider.dart';
import 'package:receipe/screens/recipe_full_description.dart';
import 'package:receipe/screens/recipe_list_templete.dart';
import 'package:receipe/widgets/alertTwoButton.dart';
import 'package:receipe/widgets/favourite_icon.dart';
import 'package:receipe/widgets/recipe_details.dart';
import 'package:receipe/widgets/recipe_from_query.dart';

import '../models/recipe.dart';
import '../utilities/abstract_colors.dart';

class DisplayRecipes extends StatefulWidget {
  final List<Recipes> recipeList;
  final String? recent;
  DisplayRecipes({super.key, required this.recipeList, this.recent});

  @override
  State<DisplayRecipes> createState() => _DisplayRecipesState();
}

class _DisplayRecipesState extends State<DisplayRecipes> {
  @override
  Widget build(BuildContext context) {
    // Recipes recipe=recipeList[];
    return SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          ...List.generate(
            widget.recipeList!.length,
            (index) {
              Recipes recipe = widget.recipeList![index];
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(child:  RecipesDesciption(recipe: recipe), type:PageTransitionType.fade,alignment: Alignment.bottomLeft ,duration:Duration(seconds: 1)));
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RecipesDesciption(recipe: recipe)));*/
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.recent != null)
                        InkWell(
                            onTap: () {
                              /* Navigator.push(context, MaterialPageRoute(builder: (context)=>confirm(Taskindex: index)));*/
                             
                              Provider.of<RecipeFireProvider>(context,
                                      listen: false)
                                  .addRecipeToFavourite(
                                      "recently_viewd_users_ids",
                                      recipe.id!,
                                      false);
                                   
                                      
                            },
                            child: Icon(
                              Icons.cancel_outlined,
                              size: 16,
                              color: Colors.grey,
                            )),
                      Card(
                        color: Color(ConstColors.bgInput),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.all(0),
                        elevation: 0,
                        child: ListTile(
                          minVerticalPadding: 10,
                          horizontalTitleGap: 0,
                          minLeadingWidth: 90,
                          titleAlignment: ListTileTitleAlignment.top,
                          contentPadding: EdgeInsets.all(0),
                          leading: Container(
                            //color: Colors.red,
                            child: Image.asset(
                              "assets/images/${recipe?.image}",
                              width:
                                  110, 

                              //fit: BoxFit.cover,
                            ),
                          ),
                          title: RecipeDetails(
                            recipe: recipe,
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FavouriteIconWidget(recipe: recipe),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
