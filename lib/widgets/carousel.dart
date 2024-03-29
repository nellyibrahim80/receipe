import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/read_ads_fire_provider.dart';
import '../utilities/abstract_colors.dart';

class AdvCarousel extends StatefulWidget {
  const AdvCarousel({super.key});

  @override
  State<AdvCarousel> createState() => _AdvCarouselState();
}

class _AdvCarouselState extends State<AdvCarousel> {
  @override
  void initState() {
    // TODO: implement initState

    initAds();
  }

  void initAds() async {
    await Provider.of<ReadFireAdsProvider>(listen: false, context)
        .getAdsFromFire();
  }
  @override
  void dispose() {
    // TODO: implement dispose
     Provider.of<ReadFireAdsProvider>(listen: false, context)
        .disposeCarousel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReadFireAdsProvider>(
      builder: (BuildContext context, value, Widget? child) =>
          value?.adsList == null
              ? CircularProgressIndicator()
              : (value.adsList?.isEmpty ?? false)
                  ? Text("no data")
                  : Stack(children: [
                      Column(
                        children: [
                          CarouselSlider(
                            carouselController: value.carousel,
                            options: CarouselOptions(
                                height: 150.0,
                                viewportFraction: 1,
                                autoPlay: true,
                                onPageChanged: (index, _) =>
                                    value.onPageChanged(index),
                                enlargeFactor: .3),
                           
                            items: value.adsList!.map((ad) {
                        return Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image:  AssetImage(
                                                    "assets/images/${ad.image}"))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    ad.title.toString(),
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                            
                           
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DotsIndicator(
                            dotsCount: value.adsList!.length,
                            position: value.current!.toInt(),
                            decorator: DotsDecorator(
                              activeColor: Color(ConstColors.titleColors),
                              size: const Size.square(9.0),
                              activeSize: const Size(18.0, 9.0),
                              activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                            onTap: (position) => value.onTapMovPos(position),
                          ),
                        ],
                      ),
                      Positioned(
                          top: 90,
                          left: 0,
                          child: Opacity(
                              opacity: .5,
                              child: IconButton(
                                onPressed: () => value.onPressedCarouselPrev(),
                                icon: Icon(Icons.arrow_back_ios_new_outlined),
                              ))),
                      Positioned(
                        top: 90,
                        right: 0,
                        child: Opacity(
                          opacity: .5,
                          child: IconButton(
                            onPressed: () => value.onPressedCarouselNext(),
                            icon: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ),
                      ),
                    ]),
    );
  }
}
