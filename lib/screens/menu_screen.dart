import 'package:flutter/material.dart';
import 'package:receipe/screens/ingredient.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ListTile(
                   title: TextButton( child: Text("Ingredient",style: TextStyle(color: Colors.black87),),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IngredientPage()));
                  },
                 ),
              leading: Icon(Icons.food_bank_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
