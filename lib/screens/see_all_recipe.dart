import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:receipe/widgets/Search.dart';
import '../providers/recipe_fire_provider.dart';
import '../widgets/recommended.dart';
import '../widgets/see_all.dart';
import 'menu_screen.dart';

class ListRecipes extends StatefulWidget {
  const ListRecipes({super.key});

  @override
  State<ListRecipes> createState() => _ListRecipesState();
}

class _ListRecipesState extends State<ListRecipes> {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  void initState() {
    // TODO: implement initState
    Provider.of<RecipeFireProvider>(context, listen: false).getDBRecipe();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      disableDragGesture: true,
      mainScreenTapClose: true,
      menuBackgroundColor: Colors.white,
      menuScreen: MenuScreen(),
      mainScreen:   Scaffold(
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
    SeeAllHeader(
    HeaderTitle: "Today's Fresh Recipes",
    ),
    recProValue.recipeList == null
    ? const CircularProgressIndicator()
        : (recProValue.recipeList?.isEmpty ?? false)
    ? const Text('No Recipes Found')
        : Recommended(
    recipeList: recProValue.recipeList,
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
