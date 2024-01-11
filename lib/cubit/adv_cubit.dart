import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';

import '../models/advs.dart';

part 'adv_state.dart';

class AdvCubit extends Cubit<AdvState> {
  AdvCubit() : super(AdvInitial());

  void initdata() async {
    emit(AdvInitial());
    var adsData = await rootBundle.loadString("assets/data/data.json");
    var decodedData = List<Map<String, dynamic>>.from(jsonDecode(adsData)["ads"]);
    var decodedRecipe=List<Map<String,dynamic>>.from(jsonDecode(adsData)["recipes"]);
     var advList=decodedData.map((e) => Advs.fromJson(e)).toList();
    emit(AdvLoaded(advList: []));
    print("----------------$decodedRecipe");

  }

}
