import 'package:flutter/material.dart';

abstract class ConstColors {
  static const int titleColors = 0xfff45b00; //orange
  static const int whiteColor = 0xffffffff; //white
  static const int blackC = 0xff000000; //black
  static const int textInput = 0xffabafbe; //dark grey
  static const int bgInput = 0xfff7f8fc; //light grey
  static const int lightGreyBg = 0xffe1e3e9;
  static const int lightOrangeBg = 0xfffddecc;
  // static const int bgInput=0xffd7d7d7; //light grey
  static const int textCyanInput = 0xff1F95B3;
  static const int textSearchInput = 0xff70737c;
    static const int lightOrangesrch = 0xfff55a00; //search text orange
  static const Widget line = Divider(
    color: Color.fromARGB(255, 227, 227, 227),
  );
  static const TextStyle headerTxtStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
}
