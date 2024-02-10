import 'package:flutter/material.dart';
import 'package:receipe/utilities/abstract_colors.dart';

class SmallGrey extends StatelessWidget {
  IconData usedIcon;
  String usedValue;
  String txt;
  double? txtSize;
   SmallGrey({super.key,required this.txt,required this.usedIcon,required this.usedValue,this.txtSize});

  @override
  Widget build(BuildContext context) {
    return  Row(
            children: [
              Icon(usedIcon,
                  color: Color(ConstColors.textInput), size:(txtSize !=null) ?txtSize!+5 : 15),
              Text(' ${usedValue} $txt',
                  style: TextStyle(
                      color: Color(ConstColors.textInput), fontSize:(txtSize !=null) ? txtSize: 10)),
            
            ],
          );
  }
}