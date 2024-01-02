import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utilities/abstract_colors.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  int current = 0;
  CarouselController carousel = CarouselController();
  TextEditingController searchCtrl = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    initdata();
    super.initState();
  }

  void initdata() async {
    var adsData = await rootBundle.loadString("assets/data/data.json");
    var decodedData =
    List<Map<String, dynamic>>.from(jsonDecode(adsData)["ads"]);
    print("----------------${decodedData}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: IconButton(
            icon: Image.asset(
                'assets/Icons/menu.png'), // Replace with your image path
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
                  'assets/Icons/notifications.png'), // Replace with your image path
              onPressed: () {
                // Your onPressed logic here
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 102,
                      child: Column(
                        children: [
                          Text("What Would you like to Cook today?"),
                          TextFormField(
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
                            style: const TextStyle(
                                color: Color(ConstColors.textInput)),
                          ),
                        ],
                      ),
                    ),
                    FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Color(ConstColors.bgInput),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset("assets/Icons/filter.png"),
                        ))
                  ],
                ),

              ],
            ),
            Center(
              child: Stack(children: [
                Column(
                  children: [
                    CarouselSlider(
                      carouselController: carousel,
                      options: CarouselOptions(
                          height: 200.0,
                          viewportFraction: 1,
                          autoPlay: false,
                          onPageChanged: (index, _) {
                            current = index;
                            setState(() {});
                          }),
                      items: [1, 2, 3, 4, 5].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5.0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/image$i.png")),
                                    color: Colors.red),
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
                    AnimatedSmoothIndicator(
                      onDotClicked: (position) async {
                        print("---------------->$position");
                        current = position;
                        await carousel.animateToPage(position);
                        setState(() {});
                      },
                      activeIndex: current,
                      count: 5,
                      effect: WormEffect(),
                    )
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
          ],
        ),
      ),
    );
  }
}
