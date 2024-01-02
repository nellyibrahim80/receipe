import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../services/shared_pref.dart';
import '../utilities/abstract_colors.dart';
import '../widgets/BlackTitle.dart';
import '../widgets/recipe_details.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    initdata();
    //SharedPrefClass.pref.clear();
    super.initState();
  }

  void initdata() async {
    var adsData = await rootBundle.loadString("assets/data/data.json");
    var decodedData =
        List<Map<String, dynamic>>.from(jsonDecode(adsData)["ads"]);
    print("----------------$decodedData");
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Bonjour, ${SharedPrefClass.pref.getString("Email")}",
                    style:
                        const TextStyle(color: Color(ConstColors.textInput))),
              ],
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
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(ConstColors.bgInput))),

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
                    style: const TextStyle(color: Color(ConstColors.textInput)),
                  ),
                ),
                Container(
                  height: 40,
                  color: Color(ConstColors.bgInput),
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
              child: Stack(children: [
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
                      items: [1, 2, 3, 4, 5].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/image$i.png")),
                                    color: Colors.white),
                                child: Text(
                                  'text $i',
                                  style: const TextStyle(fontSize: 16.0),
                                ));
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
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
                    // AnimatedSmoothIndicator(
                    //
                    //   onDotClicked: (position) async {
                    //     print("---------------->$position");
                    //     current = position;
                    //     await carousel.animateToPage(position);
                    //     setState(() {});
                    //   },

                    //   activeIndex: current,
                    //   count: 5,
                    //   effect: WormEffect(),
                    // )
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
              ]),
            ),
            SeeAllHeader(
              HeaderTitle: "Today's Fresh Recipes",
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(3, (index) => SizedBox(
                    width: 185,
                    // height: 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(25)),
                        color: Color(ConstColors.bgInput),
                        elevation: 0,
                        //shadowColor: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      "assets/images/image${index}small.png",
                                      width: 200, // Ensure that this value does not exceed maxWidth
                                      height: 80,
                                      //fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            RecipeDetails(RecipeIndex: 1,starsPadding: 6,)
                          ],
                        ),
                      ),
                    ),
                  ))

                ],
              ),
            ),
            SeeAllHeader(
              HeaderTitle: "Recommended",
            ),
            Card(
              color: Color(ConstColors.bgInput),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),

              margin: EdgeInsets.all(0),
              elevation: 0,
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.top,
                contentPadding: EdgeInsets.all(0 ),
                leading: Container(
                 // color: Colors.red,
                  child: Image.asset(
                  "assets/images/image0small.png",
                  width: 120, // Ensure that this value does not exceed maxWidth

                  //fit: BoxFit.cover,
                                ),
                ),title: RecipeDetails(RecipeIndex: 1,),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                                      Icons.favorite_border,
                                      color: Color(ConstColors.textInput),
                                    ),
                    ],
                  ),),
            )
          ],
        ),
      )),
    );
  }
}
