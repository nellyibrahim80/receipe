

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:receipe/utilities/abstract_colors.dart';

class StarsRate extends StatelessWidget {
  double recipeRate;
   StarsRate({super.key,required this.recipeRate});

  @override
  Widget build(BuildContext context) {
    return  Align( alignment: Alignment.topLeft,

              child: RatingBar.builder(
                initialRating:recipeRate,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,

                itemSize: 20,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) =>const Icon(
                  Icons.star,
                  color: Color(ConstColors.titleColors),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            );
  }
}