import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:overlay_kit/overlay_kit.dart';

import '../models/ingredient.dart';
import '../utilities/toest_message_status.dart';
import '../widgets/ToastMessage.dart';

class IngredientFireProvider extends ChangeNotifier {
  List<Ingredient> ingredientList = [];
  String? whereCriteria;
  dynamic query;
  late QuerySnapshot<Map<String, dynamic>> IngredientDbList;
  Future<void> getIngredient(String s, {whereCriteria}) async {
    try {
      var firebaseIns =
          await FirebaseFirestore.instance.collection("ingredient");
      /*if (whereCriteria != null) {
        var IngredientDbList = await firebaseIns
          .where(whereCriteria,
                  arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .get();
      } else {
        var IngredientDbList = await firebaseIns.get();
      }
*/
      (whereCriteria == "user_ids")
            ? IngredientDbList =await (query as Query<Map<String, dynamic>>).where(whereCriteria,
                  arrayContains: FirebaseAuth.instance.currentUser!.uid).get()
            : IngredientDbList = await firebaseIns.get();
      if (IngredientDbList.docs.isNotEmpty) {
        ingredientList = List<Ingredient>.from(IngredientDbList.docs
            .map((e) => Ingredient.fromJson(e.data(), e.id)));
        print(ingredientList);
        print("-----------------------------------");
      }
    } catch (e) {
      print('---------error in ingredint provider ------$e');
    }
    notifyListeners();
  }

  //////////////////////////
  Future<void> addIngredientToUser(String ingredientId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('ingredient')
            .doc(ingredientId)
            .update({
          "user_ids":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('ingredient')
            .doc(ingredientId)
            .update({
          "user_ids":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }
      OverlayLoadingProgress.stop();
      getIngredient('');
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: ToastMessageWidget(
          message: 'Error : ${e.toString()}',
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
    }
  }
///////////////////////////
}
