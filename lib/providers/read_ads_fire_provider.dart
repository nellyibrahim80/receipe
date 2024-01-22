import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../models/advs.dart';

class ReadFireAdsProvider extends ChangeNotifier {
  List<Advs>? adsList = [];

  Future<void> getAdsFromFire() async {
    try {
      var firestoreResult =
          await FirebaseFirestore.instance.collection("Ads").get();
      if (firestoreResult.docs.isNotEmpty) {
        adsList = List<Advs>.from(
            firestoreResult.docs.map((e) => Advs.fromJson(e.data(), e.id)));
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
