import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe/providers/ingredient_provider.dart';
import 'package:receipe/screens/home_page.dart';

class IngredientPage extends StatefulWidget {
  const IngredientPage({super.key});

  @override
  State<IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<IngredientFireProvider>(context,listen: false).getIngredient();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading:
            IconButton(icon: Icon(Icons.arrow_back_outlined), onPressed: () {Navigator.push(context, MaterialPageRoute(builder:  (context) => HomePage(),));}),
      ),
      body: Consumer<IngredientFireProvider>(

  builder: (context, ingProvValue,_)  {
    return  Column(
        children: [
          ingProvValue.ingredientList == null
              ? const CircularProgressIndicator()
              : (ingProvValue.ingredientList?.isEmpty ?? false)
              ? const Text('No Ingredient Found')
              :ListView.builder(
            itemCount: ingProvValue.ingredientList?.length,
            itemBuilder: (context, index) {
              var inglist=ingProvValue.ingredientList?[index];
            ListTile(
              title: Text(inglist!.name.toString() ?? ""),
            );
              },)

        ],
      );
  },
),
    );
  }
}
