import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe/models/ingredient.dart';
import 'package:receipe/providers/ingredient_provider.dart';
import 'package:receipe/utilities/abstract_colors.dart';

class IngredientList extends StatefulWidget {
  final List<String> recipeIngredientList;
  const IngredientList({super.key, required this.recipeIngredientList});

  @override
  State<IngredientList> createState() => _ingredientListState();
}

class _ingredientListState extends State<IngredientList> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<IngredientFireProvider>(context, listen: false).getIngredient( 'user_ids');
    super.initState();
  }

  Widget build(BuildContext context) {
    double getTextWidth(String text) {
      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(fontSize: 12.0),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      return textPainter.width + 95;
    }

    return Consumer<IngredientFireProvider>(
      builder: (context, ingProvValue, _) { 
         bool isExsist = false;
          var userIngredientsTitles =
                          ingProvValue.ingredientList .map((e) => e.name).toList();
                                          Widget checkIngredientWidget(String recipeIngredient) {
                        bool isExsist = false;
                        for (var userIngredientsTitle in userIngredientsTitles) {
                          if (recipeIngredient.contains(userIngredientsTitle!.toLowerCase())) {
                            isExsist = true;
                            break;
                          } else {
                            isExsist = false;
                          }
                        }
                        
                         return (isExsist)?  Icon(Icons.check_circle_outline,color: Colors.green)
                                            : Icon(Icons.cancel_outlined,color: Colors.red );
                       Icon(Icons.check);
                  
                        }
                              // 
        return Column(
          children: [
            ingProvValue.ingredientList == null
                ? const CircularProgressIndicator()
                : (ingProvValue.ingredientList?.isEmpty ?? false)
                    ? const Text('No Ingredient Found')
                    : Column(
                      children: [

                        const Padding(
                          padding: EdgeInsets.only(top:20.0),
                          child: Row(
                                children: [
                                  Text(
                                    "Ingredients",
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                        ),Column(
                              children:  widget.recipeIngredientList
                              ?.map((e) => Row(
                                    children: [
                                      SizedBox(
                                        width: 365,
                                        child: ListTile(
                                          contentPadding: EdgeInsets.all(0),
                                          leading:   SizedBox(
                                        width: 50,
                                        child:checkIngredientWidget(e)
                                          ),
                                          title: Text(e)),
                                      ),
                                      
                                     
                                    ],
                                  ))
                              .toList() ?? []
                            ),
                      /*  SizedBox(
                            height: 60,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: ingProvValue.ingredientList?.length,
                              itemBuilder: (context, index) {
                               
                                var userInglist = ingProvValue.ingredientList[index];
                                
                                return SizedBox(
                                  width:
                                      getTextWidth(userInglist?.name.toString() ?? "?")
                                          .toDouble(),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    tileColor: Color(ConstColors.bgInput),
                                    leading: SizedBox(
                                      width: 20,
                                      child: (userInglist?.user_ids?.contains(
                                                  FirebaseAuth
                                                      .instance.currentUser?.uid) ??
                                              false)
                                          ? Icon(Icons.check_circle_outline,color: Colors.green)
                                          : Icon(Icons.cancel_outlined,color: Colors.red ),
                                    ),
                                    title: Text(
                                      "${userInglist?.name.toString() ?? "?"}",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                     */ ],
                    )
          ],
        );
      },
    );
  }
}
