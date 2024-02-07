import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:receipe/models/recipe.dart';
import 'package:receipe/utilities/abstract_colors.dart';
import 'package:receipe/widgets/Search.dart';
import '../providers/recipe_fire_provider.dart';
import '../widgets/recommended.dart';
import '../widgets/sub_header.dart';
import 'menu_screen.dart';

class ListRecipes extends StatefulWidget {
  final List<Recipes> Targetrecipe;
  const ListRecipes({super.key, required this.Targetrecipe});

  @override
  State<ListRecipes> createState() => _ListRecipesState();
}

class _ListRecipesState extends State<ListRecipes> {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  void initState() {
    // TODO: implement initState
    // Provider.of<RecipeFireProvider>(context, listen: false).getDBRecipe();
    Provider.of<RecipeFireProvider>(context, listen: false)
        .getDefinedRecipes("recipes", "all", "", widget.Targetrecipe);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      disableDragGesture: true,
      mainScreenTapClose: true,
      menuBackgroundColor: Color(ConstColors.bgInput),
      menuScreen: MenuScreen(),
      mainScreen: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: Image.asset(
                'assets/Icons/menu.png',
                width: 80,
                height: 80,
              ),
              onPressed: () {
                // Your onPressed logic here
                zoomDrawerController.toggle!();
              },
            ),
          ),
          title: Text('Recipes'),
        ),
        body: Consumer<RecipeFireProvider>(
          builder: (context, recProValue, _) {
            return Column(
              children: [
                SearchWidget(),
              
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
        ),
      ),
      borderRadius: 24.0,
      showShadow: true,
      angle: -5.0,
      drawerShadowsBackgroundColor: Colors.grey.shade300,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}
