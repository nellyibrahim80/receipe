import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe/providers/ingredient_provider.dart';


class IngredientPage extends StatefulWidget {
  const IngredientPage({super.key});

  @override
  State<IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<IngredientFireProvider>(context, listen: false).getIngredient();
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
              ingProvValue.ingredientList == null
                  ? const CircularProgressIndicator()
                  : (ingProvValue.ingredientList?.isEmpty ?? false)
                      ? const Text('No Ingredient Found')
                      : SizedBox(
                          height: 500,
                          child: ListView.builder(
                            itemCount: ingProvValue.ingredientList?.length,
                            itemBuilder: (context, index) {
                              var inglist = ingProvValue.ingredientList?[index];
                              return ListTile(
                                leading: Checkbox(
                                    value: inglist?.user_ids?.contains(
                                        FirebaseAuth.instance.currentUser?.uid),
                                    onChanged: (value) {
                                      ingProvValue.addIngredientToUser(
                                          inglist!.id!, value ?? false);
                                    }),
                                title: Text(
                                  "${inglist?.name.toString() ?? "?"}",
                                ),
                              );
                            },
                          ),
                        )
            ],
          );
        },
      ),
    );
  }
}
