import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:provider/provider.dart';
import 'package:receipe/screens/recipe_full_description.dart';
import 'package:receipe/widgets/Search.dart';

import 'package:receipe/widgets/recipe_widget.dart';

import '../models/advs.dart';
import '../models/recipe.dart';
import '../providers/auth_provider.dart';
import '../providers/read_ads_fire_provider.dart';
import '../providers/recipe_fire_provider.dart';

import '../utilities/abstract_colors.dart';
import '../widgets/BlackTitle.dart';
import '../widgets/carousel.dart';

import '../widgets/recommended.dart';
import '../widgets/sub_header.dart';
import 'menu_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current = 0;
  CarouselController carousel = CarouselController();
  TextEditingController searchCtrl = TextEditingController();
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  List<Advs> advList = [];
  //List<Recipes> RecipeList = [];
  @override
  void initState() {
    // TODO: implement initState

    Provider.of<ReadFireAdsProvider>(listen: false, context).getAdsFromFire();
    //Provider.of<RecipeFireProvider>(listen: false, context).getDBRecipe();
    //Provider.of<RecipeFireProvider>(listen: false, context).getFreshRecipes();
    //Provider.of<RecipeFireProvider>(listen: false, context).getRecommandedRecipes();
 Provider.of<RecipeFireProvider>(context, listen: false).getDefinedRecipes("recipes", "is_fresh", false,Provider.of<RecipeFireProvider>(context, listen: false).recommendedRecipesList);
  Provider.of<RecipeFireProvider>(context, listen: false).getDefinedRecipes("recipes", "is_fresh",true,Provider.of<RecipeFireProvider>(context, listen: false).freshRecipesList);

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
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IconButton(
                icon: Image.asset(
                  'assets/Icons/notifications.png',
                  width: 30,
                  height: 80,
                ), // Replace with your image path
                onPressed: () {
                  // Your onPressed logic here
                },
              ),
            )
          ],
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<AuthFirebaseProvider>(
                  builder: (context, value, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //    Text("Bonjour, ${SharedPrefClass.pref.getString("Email")}", //With Abstract class
                      Text(
                          // "Bonjour, ${GetIt.I.get<SharedPreferences>().getString("Email")}", //With Get It singleton
                          "Bonjour, ${FirebaseAuth.instance.currentUser?.displayName ?? "Anonoymous"}",
                          style: const TextStyle(
                              color: Color(ConstColors.textInput))),
                      IconButton(
                        onPressed: () {
                          value.SignOut(context);
                        },
                        icon: Icon(Icons.logout),
                        tooltip: "Sign Out",
                      )
                    ],
                  ),
                ),
                HeaderBlack(
                  HeaderBlackTitle: "What would you like to cook today?",
                ),
               SearchWidget(),
                SizedBox(width: 370, height: 200, child: AdvCarousel()),
                SeeAllHeader(
                  HeaderTitle: "Today's Fresh Recipes",
                ),
                Consumer<RecipeFireProvider>(
                  builder: (cntxt, Rvalue, child) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 210,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                            
                              Recipes recipe = Rvalue.freshRecipesList![index];

                              return SizedBox(
                                width: 185,
                                // height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                25)),
                                    color: Color(ConstColors.bgInput),
                                    elevation: 0,
                                    //shadowColor: Colors.white,
                                    child: InkWell(
                                        onTap: (){  Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>RecipesDesciption(recipe: recipe) ));},
                                      child: RecipeWidget(
                                        index: index,
                                        recipe: recipe,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: Rvalue.freshRecipesList?.length ?? 3,
                          ),
                        ),
                        SeeAllHeader(
                          HeaderTitle: "Recommended",
                        ),
                        if (Rvalue.recommendedRecipesList != null)
                          DisplayRecipes(
                            recipeList: Rvalue.recommendedRecipesList,
                          )
                        else
                          CircularProgressIndicator(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        )),
      ),
      borderRadius: 24.0,
      showShadow: true,
      angle: -5.0,
      drawerShadowsBackgroundColor: Colors.grey.shade300,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}
