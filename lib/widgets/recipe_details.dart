import 'package:flutter/material.dart';

import '../utilities/abstract_colors.dart';

class RecipeDetails extends StatelessWidget {
  final int RecipeIndex;
   final double? starsPadding ;
   RecipeDetails({required this.RecipeIndex,this.starsPadding,super.key});

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry padding = EdgeInsets.only(
      bottom: starsPadding ?? 0.0,
      top: starsPadding ?? 0.0,
    );
    return Container(
      //color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Breakfast',
              style: TextStyle(
                  color: Color(ConstColors.textCyanInput),
                  fontSize: 12),
            ),
          ],
        ),
          Row(
            children: [

              Text(
                'French Toast With Berries',
              ),
            ],
          ),
          Padding(
            padding: padding,
            child: Row(
              children: [
                ...List.generate(
                    5,
                        (index) => Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: Color(ConstColors.titleColors),
                    )),
                 
              ],
            ),
          ),

          Row(
            children: [
              Text('120 Calories',
                  style: TextStyle(
                      color: Color(ConstColors.titleColors),
                      fontSize: 10)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(

              children: [

                Icon(
                    Icons.access_time_rounded,
                    color: Color(ConstColors.textInput),size: 15),
                Text(' 12 min',
                    style: TextStyle(
                        color: Color(ConstColors.textInput),
                        fontSize: 10)),
                SizedBox(width: 15,),
                Icon(
                    Icons.room_service_outlined,
                    color: Color(ConstColors.textInput),size: 15),
                Text(' 1 ٍserving',
                    style: TextStyle(
                        color: Color(ConstColors.textInput),
                        fontSize: 10)),
              ],
            ),
          )],
      ),
    );
  }
}
