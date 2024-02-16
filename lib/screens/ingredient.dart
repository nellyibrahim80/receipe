import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe/providers/ingredient_provider.dart';
import 'package:receipe/utilities/abstract_colors.dart';


class IngredientPage extends StatefulWidget {
  const IngredientPage({super.key});

  @override
  State<IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<IngredientFireProvider>(context, listen: false).getIngredient( '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ingredient'),
        ),
        body: Consumer<IngredientFireProvider>(
          builder: (context, ingProvValue, _) {
            return Column(
              children: [
                Row
                (mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  ...List.generate(6, (index) =>  Image.asset(
                              "assets/images/${index}.jpg",
                              width:
                                  50,
                            ),)
                 
                ],),

                ingProvValue.ingredientList == null
                    ? const CircularProgressIndicator()
                    : (ingProvValue.ingredientList?.isEmpty ?? false)
                        ? const Text('No Ingredient Found')
                        : SizedBox(
                            height: 510,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: ingProvValue.ingredientList?.length,
                              itemBuilder: (context, index) {
                                var inglist =
                                    ingProvValue.ingredientList?[index];
                                // print(getTextWidth(inglist?.name.toString() ?? "?"));
                                return SizedBox(
                                  width: 250,
                                  child: ListTile(
                                    leading: SizedBox(
                                      width: 20,
                                      child: Checkbox(
                                        value: inglist?.user_ids?.contains(
                                            FirebaseAuth
                                                .instance.currentUser?.uid),
                                        onChanged: (value) {
                                          ingProvValue.addIngredientToUser(
                                              inglist!.id!, value ?? false);
                                        },
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, 
  shape: RoundedRectangleBorder(
    side: BorderSide(
      color: Colors.grey, 
    ),
    borderRadius: BorderRadius.circular(4), 
  ),

                                        checkColor: Color(ConstColors.titleColors), 
                                        activeColor: Color(ConstColors.bgInput),
                                        
                                      ),
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
        ));
  }
}
