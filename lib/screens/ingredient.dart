import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe/providers/ingredient_provider.dart';
import 'package:receipe/widgets/ingredient_list.dart';


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
      body:IngredientList()
      
     
    );
  }
}
