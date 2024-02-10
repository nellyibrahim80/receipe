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
    Provider.of<IngredientFireProvider>(context, listen: false).getIngredient('user_ids');
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
         
        return Column(
          children: [
            ingProvValue.ingredientList == null
                ? const CircularProgressIndicator()
                : (ingProvValue.ingredientList?.isEmpty ?? false)
                    ? const Text('No Ingredient Found')
                    : SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ingProvValue.ingredientList?.length,
                          itemBuilder: (context, index) {
                            var userIngredientsTitles =
                      ingProvValue.ingredientList .map((e) => e.name).toList();
                  Widget checkIngredientWidget(String recipeIngredient) {
                    bool isExsist = false;
                    for (var userIngredientsTitle in userIngredientsTitles) {
                      if (recipeIngredient.contains(userIngredientsTitle!)) {
                        isExsist = true;
                        break;
                      } else {
                        isExsist = false;
                      }
                    }
                    return Container();
                    }
                            var inglist = ingProvValue.ingredientList?[index];
                            
                            print(
                                getTextWidth(inglist?.name.toString() ?? "?"));
                            return SizedBox(
                              width:
                                  getTextWidth(inglist?.name.toString() ?? "?")
                                      .toDouble(),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(0),
                                tileColor: Color(ConstColors.bgInput),
                                leading: SizedBox(
                                  width: 20,
                                  child: (inglist?.user_ids?.contains(
                                              FirebaseAuth
                                                  .instance.currentUser?.uid) ??
                                          false)
                                      ? Icon(Icons.check_circle_outline,color: Colors.green)
                                      : Icon(Icons.cancel_outlined,color: Colors.red ),
                                ),
                                title: Text(
                                  "${inglist?.name.toString() ?? "?"}",
                                ),
                              ),
                            );
                          },
                        ),
                      )
          ],
        );
      },
    );
  }
}
