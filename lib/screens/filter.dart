import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe/providers/recipe_fire_provider.dart';
import 'package:receipe/screens/recipe_list_templete.dart';
import 'package:receipe/utilities/abstract_colors.dart';
import 'package:receipe/widgets/recipe_from_query.dart';


class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  Map<String,dynamic> selectedUserValue = {};
    double _serving = 1;
    double _prepTime = 5;
    double _calories = 10;
 
 
    void initState() {
    // TODO: implement initState
             var targetRecipe=Provider.of<RecipeFireProvider>(context, listen: false).mealtypeList;

    Provider.of<RecipeFireProvider>(context, listen: false)
        .getDefinedRecipes("recipes", "all", "", targetRecipe);
    super.initState();
  }
  @override
  // TODO: implement widget
  Widget customedSlider(String title,String mapKey,double min,double max,int divisions,var varName,  Function(double) onChangedCallback,){
     return Column(
       children: [
         Padding(
                 padding: EdgeInsets.only(top:30.0),
                 child: Row(
                           children: [
                  Text(
                   title,
                    style: ConstColors.headerTxtStyle,
                  ),
                           ],
                         ),
               ), Slider(
            value: varName,
         //
          min: min,
         max:max,
         divisions:divisions ,
              thumbColor: const Color(ConstColors.titleColors),
            activeColor:  const Color(ConstColors.titleColors),
            inactiveColor: const Color(ConstColors.lightGreyBg),
            label: varName.round().toString(),
            onChanged: (double value) {
               onChangedCallback(value);
              // varName = value.round().toDouble();
                  selectedUserValue[mapKey] = value.round();
                 print(selectedUserValue);
              setState(() {
                
              });
            },
          ),
          Text(
        '${varName.round()}',
        style: TextStyle(fontSize: 16),
      ),
       ],
     );
          
  }
  Widget build(BuildContext context) {
    Color SwitchColor(String label, int colorA, int colorB) {
      return selectedUserValue['MealType'] == label.toLowerCase()
          ? Color(colorA)
          : Color(colorB);
    }
  var mealtypeTitles=Provider.of<RecipeFireProvider>(context, listen: true).mealtypeList;

 //var mealtypeTitles =mealtypes.map((e) => e.MealType).toSet().toList();
    Widget ChipSlide(String label) {
      return InkWell(
          onTap: () {
                      selectedUserValue['MealType'] = label.toLowerCase();
                      setState(() {});
                      print(selectedUserValue);
                    },
        child: Padding(
          padding: const EdgeInsets.only(right:8.0),
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
              Row(
  children: mealtypeTitles.map((mealTypeTitle) {
    // Assuming 'mealTypeTitle' is a String representing the meal type
    return Row(
      children: [
        ChipSlide(mealTypeTitle.MealType as String),
      ],
    );
  }).toList(),
)
               
               //ChipSlide("test"),
                //ChipSlide("BreakFast"),
                //ChipSlide("lunch"),
                //ChipSlide("Dinner"),
              ]),
        ),
        ConstColors.line,
        customedSlider("Serving","serving",0,20,100,_serving,  (newValue) {
      setState(() {
        _serving = newValue;
      });
    },),
        customedSlider("Preperation Time",'prepare',0,120,200,_prepTime,  (newValue) {
      setState(() {
        _prepTime = newValue;
      });
    },),
        customedSlider("Calories",'calories',10,2000,3000,_calories,  (newValue) {
      setState(() {
        _calories = newValue;
      });
    },),
 
    
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
