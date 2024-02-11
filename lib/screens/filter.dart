import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe/providers/recipe_fire_provider.dart';
import 'package:receipe/screens/recipe_list_templete.dart';
import 'package:receipe/utilities/abstract_colors.dart';
import 'package:receipe/widgets/recipe_from_query.dart';
import 'package:receipe/widgets/recipe_from_search.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  Map<String,dynamic> selectedUserValue = {};
    double _currentSliderPrimaryValue = 0.2;
 

  @override
  Widget build(BuildContext context) {
    Color SwitchColor(String label, int colorA, int colorB) {
      return selectedUserValue['MealType'] == label.toLowerCase()
          ? Color(colorA)
          : Color(colorB);
    }

    Widget ChipSlide(String label) {
      return InkWell(
          onTap: () {
                      selectedUserValue['MealType'] = label.toLowerCase();
                      setState(() {});
                      print(selectedUserValue);
                    },
        child: Chip(
          label: Text(label),
          backgroundColor: SwitchColor(
              label, ConstColors.lightOrangeBg, ConstColors.lightGreyBg),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          side: BorderSide(
            color: SwitchColor(
                label, ConstColors.titleColors, ConstColors.lightGreyBg),
          ),
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: SwitchColor(
                label, ConstColors.titleColors, ConstColors.textSearchInput),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Text(
              "Meal Type",
              style: ConstColors.headerTxtStyle,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Wrap(
              // space between chips
              spacing: 10,
              // list of chips
              children: [
                ChipSlide("test"),
                ChipSlide("BreakFast"),
                ChipSlide("lunch"),
                ChipSlide("Dinner"),
              ]),
        ),
        ConstColors.line,
 Padding(
     padding: const EdgeInsets.only(top:30.0),
   child: Row(
            children: [
              Text(
                "Serving",
                style: ConstColors.headerTxtStyle,
              ),
            ],
          ),
 ),
        Slider(
            value: _currentSliderPrimaryValue,
         //
              thumbColor: Color(ConstColors.titleColors),
            activeColor:  Color(ConstColors.titleColors),
            inactiveColor: Color(ConstColors.lightGreyBg),
            label: _currentSliderPrimaryValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderPrimaryValue = value;
              });
            },
          ),
           Padding(
             padding: const EdgeInsets.only(top:30.0),
             child: Row(
                       children: [
              Text(
                "Preperation Time",
                style: ConstColors.headerTxtStyle,
              ),
                       ],
                     ),
           ),
           Slider(
            value: _currentSliderPrimaryValue,
         //
              thumbColor: Color(ConstColors.titleColors),
            activeColor:  Color(ConstColors.titleColors),
            inactiveColor: Color(ConstColors.lightGreyBg),
            label: _currentSliderPrimaryValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderPrimaryValue = value;
              });
            },
          ),
            const Padding(
             padding: EdgeInsets.only(top:30.0),
             child: Row(
                       children: [
              Text(
                "Calories",
                style: ConstColors.headerTxtStyle,
              ),
                       ],
                     ),
           ),
           Slider(
            value: _currentSliderPrimaryValue,
         //
              thumbColor: const Color(ConstColors.titleColors),
            activeColor:  const Color(ConstColors.titleColors),
            inactiveColor: const Color(ConstColors.lightGreyBg),
            label: _currentSliderPrimaryValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderPrimaryValue = value;
              });
            },
          ),
             Padding(
               padding: const EdgeInsets.only(top:40.0),
               child: ElevatedButton(
                          child: const Text("Apply"),
                          onPressed: () {
                            var targetRecipe=Provider.of<RecipeFireProvider>(context, listen: false).displayRecipes;
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListRecipesTemplete(listRecipesWidget:  RecipeFromQuery(Targetrecipe: targetRecipe,whereCriteria:"search" ,condition: selectedUserValue ,), pageTitle: "Filter",)));},

                          
                        ),
             ),
         /* Slider(
            value: _currentSliderSecondaryValue,
            label: _currentSliderSecondaryValue.round().toString(),
            thumbColor: Color(ConstColors.titleColors),
            activeColor:  Color(ConstColors.titleColors),
            inactiveColor: Color(ConstColors.lightGreyBg),
            secondaryActiveColor:  Color(ConstColors.lightGreyBg),
           
            onChanged: (double value) {
              setState(() {
                _currentSliderSecondaryValue = value;
              });
            },
          ),*/
      ],
    );
  }
}
