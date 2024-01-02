import 'package:flutter/material.dart';
import 'package:receipe/widgets/recipe_details.dart';

import '../utilities/abstract_colors.dart';

class Recommended extends StatelessWidget {
  const Recommended({super.key});

  @override
  Widget build(BuildContext context) {
    return

      SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            ...List.generate(3, (index) =>  Card(
              color: Color(ConstColors.bgInput),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),

              margin: EdgeInsets.all(0),
              elevation: 0,
              child: ListTile(
                minVerticalPadding:10,
                horizontalTitleGap: 0,
                minLeadingWidth: 90,
                titleAlignment: ListTileTitleAlignment.top,
                contentPadding: EdgeInsets.all(0),
                leading: Container(
                  //color: Colors.red,
                  child: Image.asset(
                    "assets/images/image${index}small.png",
                    width: 110, // Ensure that this value does not exceed maxWidth

                    //fit: BoxFit.cover,
                  ),
                ),title: RecipeDetails(RecipeIndex: 1,),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: Color(ConstColors.textInput),
                    ),
                  ],
                ),),
            ),)

          ],
        ),
      );
  }
}
