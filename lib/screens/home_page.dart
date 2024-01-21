import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:receipe/providers/adv_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/advs.dart';
import '../models/recipe.dart';
import '../providers/auth_provider.dart';
import '../services/shared_pref.dart';
import '../utilities/abstract_colors.dart';
import '../widgets/BlackTitle.dart';
import '../widgets/recipe_details.dart';
import '../widgets/recommended.dart';
import '../widgets/see_all.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current = 0;
  CarouselController carousel = CarouselController();
  TextEditingController searchCtrl = TextEditingController();
  List<Advs> advList = [];
  List<Recipes> RecipeList = [];
  @override
  void initState() {
    // TODO: implement initState
    initdata();
    Provider.of<AdvProvider>(context, listen: false).LoadJsonFile();
    Provider.of<AdvProvider>(
      context,
      listen: false,
    ).advFromJson();
    Provider.of<AdvProvider>(context, listen: false).recipesFromJson();
    //SharedPrefClass.pref.clear();
    super.initState();
  }

  void initdata() async {
    var adsData = await rootBundle.loadString("assets/data/data.json");
    //var decodedData =
    //    List<Map<String, dynamic>>.from(jsonDecode(adsData)["ads"]);
    var decodedRecipe =
        List<Map<String, dynamic>>.from(jsonDecode(adsData)["recipes"]);
    //advList = decodedData.map((e) => Advs.fromJson(e)).toList();
    RecipeList = decodedRecipe.map((e) => Recipes.fromJson(e)).toList();
    //print("----------------$decodedRecipe");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.only(left: 20, right: 20),
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
                    IconButton(onPressed: (){
                      value.SignOut(context);
                    },icon: Icon(Icons.logout), tooltip: "Sign Out",)
                  ],
                ),
              ),
              HeaderBlack(
                HeaderBlackTitle: "What would you like to cook today?",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 320,
                    height: 40,
                    child: TextFormField(
                      controller: searchCtrl,
                      decoration: InputDecoration(
                        fillColor: Color(ConstColors.bgInput),
                        filled: true,
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        prefixIconColor: Color(ConstColors.textInput),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(ConstColors.bgInput))),

                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(ConstColors.bgInput)),
                            borderRadius: BorderRadius.circular(20)),
                        //UnderlineInputBorder(borderSide: BorderSide(color: Color(ConstColors.bgInput))),
                        hintStyle: const TextStyle(
                          color: Color(ConstColors.textInput),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      style:
                          const TextStyle(color: Color(ConstColors.textInput)),
                    ),
                  ),
                  Container(
                    height: 40,
                    color: const Color(ConstColors.bgInput),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          child: Image.asset(
                        "assets/Icons/filter.png",
                        height: 35,
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                  width: 370,
                  height: 200,
                  child: Consumer<AdvProvider>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Stack(children: [
                        Column(
                          children: [
                            CarouselSlider(
                              carouselController: carousel,
                              options: CarouselOptions(
                                  height: 150.0,
                                  viewportFraction: 1,
                                  autoPlay: true,
                                  onPageChanged: (index, _) {
                                    current = index;
                                    setState(() {});
                                  }),
                              // items: advList.map((Advs) {
                              items: value.advList.map((Advs) {
                                print(
                                    "************************${value.advList}");
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/${Advs.image}")),
                                            color: Colors.white),
                                        child: Text(
                                          Advs.title ?? "",
                                          style:
                                              const TextStyle(fontSize: 16.0),
                                        ));
                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DotsIndicator(
                              dotsCount: 5,
                              position: current,
                              decorator: DotsDecorator(
                                activeColor: Color(ConstColors.titleColors),
                                size: const Size.square(9.0),
                                activeSize: const Size(18.0, 9.0),
                                activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                              onTap: (position) async {
                                current = position;
                                await carousel.animateToPage(position);
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        Positioned(
                            top: 90,
                            left: 0,
                            child: Opacity(
                                opacity: .5,
                                child: IconButton(
                                  onPressed: () async {
                                    await carousel.previousPage();
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.arrow_back_ios_new_outlined),
                                ))),
                        Positioned(
                          top: 90,
                          right: 0,
                          child: Opacity(
                            opacity: .5,
                            child: IconButton(
                              onPressed: () async {
                                await carousel.nextPage();
                                setState(() {});
                              },
                              icon: Icon(Icons.arrow_forward_ios_outlined),
                            ),
                          ),
                        ),
                      ]);
                    },
                  )),
              SeeAllHeader(
                HeaderTitle: "Today's Fresh Recipes",
              ),
              Consumer<AdvProvider>(
                builder: (cntxt, Rvalue, child) {
                  return SizedBox(
                    height: 210,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        print("${index}????=====?????????????");
                        Recipes recipe = Rvalue.RecipeList[index];

                        return SizedBox(
                          width: 185,
                          // height: 100,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(25)),
                              color: Color(ConstColors.bgInput),
                              elevation: 0,
                              //shadowColor: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.favorite_border,
                                        color: Color(ConstColors.textInput),
                                      ),
                                      Container(
                                        width: 90,
                                        height: 80,
                                        child: OverflowBox(
                                          alignment: FractionalOffset.topLeft,
                                          maxWidth: 130,
                                          child: Image.asset(
                                            "assets/images/${recipe.image}",
                                            width:
                                                200, // Ensure that this value does not exceed maxWidth
                                            height: 80,
                                            //fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  RecipeDetails(
                                    RecipeIndex: index,
                                    starsPadding: 6,
                                    recipeList: Rvalue.RecipeList,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: Rvalue.RecipeList.length,
                    ),
                  );
                },
              ),
              SeeAllHeader(
                HeaderTitle: "Recommended",
              ),
              if (RecipeList != Null)
                Recommended(
                  recipeList: RecipeList,
                )
              else
                CircularProgressIndicator(),
            ],
          ),
        ),
      )),
    );
  }
}
