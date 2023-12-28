import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current=0;
  CarouselController carousel=CarouselController();
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Center(
        child: Column(
          children: [

            CarouselSlider(
              carouselController: carousel,
              options: CarouselOptions(
                  height: 300.0,
                  viewportFraction:1 ,
                  autoPlay: false,
                onPageChanged: (index,_){
                  current=index;
                  setState(() {});
                }

              ),
              items: [1,2,3,4,5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration:  BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/image$i.png")),
                            color: Colors.amber
                        ),
                        child: Text('text $i', style: const TextStyle(fontSize: 16.0),)
                    );
                  },
                );
              }).toList(),
            ),
            FloatingActionButton(onPressed: () async{
              await carousel.nextPage();
              setState(() {

              });
            },child: Icon(Icons.arrow_back_ios_new_outlined),),
            FloatingActionButton(onPressed: () async{
              await carousel.previousPage();
                  setState(() {

                  });
            },child: Icon(Icons.arrow_forward_ios_outlined),),
            SizedBox(height: 10,),
            AnimatedSmoothIndicator(
              onDotClicked: (position) async{
                print("---------------->$position");
                current=position;
                await carousel.animateToPage(position);
                setState(() {

                });
              },
              activeIndex: current,
              count: 5,
              effect: WormEffect(),
            )
          ],
        ),
      ),
    );
  }
}
