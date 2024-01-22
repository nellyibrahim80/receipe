import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../models/advs.dart';

class ReadFireAdsProvider extends ChangeNotifier {
  List<Advs>? adsList = [];
  CarouselController? carousel;
  int? current=0;

  void onTapMovPos (position) async {
    current = position;
    await carousel?.animateToPage(position);
    notifyListeners();}
  void onPressedCarouselPrev() async {
    await carousel?.previousPage();
   notifyListeners();
  }
  void onPressedCarouselNext() async {
    await carousel?.nextPage();
    notifyListeners();
  }
  Future<void> getAdsFromFire() async {
    try {
      var firestoreResult =
          await FirebaseFirestore.instance.collection("ads").get();
     // print("------------------------------------$firestoreResult");
      if (firestoreResult.docs.isNotEmpty) {
        adsList = List<Advs>.from(
            firestoreResult.docs.map((e) => Advs.fromJson(e.data(), e.id)));
        print("------------------------------------$adsList.");
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
