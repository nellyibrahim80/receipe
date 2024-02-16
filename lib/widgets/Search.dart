import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:receipe/screens/filter.dart';
import 'package:receipe/screens/recipe_list_templete.dart';

import '../models/recipe.dart';
import '../screens/recipe_full_description.dart';
import '../utilities/abstract_colors.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchCtrl = TextEditingController();
  String name = "";

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder textBoxBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Color(ConstColors.bgInput)),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min, // Set mainAxisSize to MainAxisSize.min
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 338,
                height: 40,
                child: TextFormField(
                  controller: searchCtrl,
                  decoration: InputDecoration(
                    fillColor: Color(ConstColors.bgInput),
                    filled: true,
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Color(ConstColors.textInput),
                    enabledBorder: textBoxBorder,
                    border: textBoxBorder,
                    hintStyle: const TextStyle(
                      color: Color(ConstColors.textInput),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  style: const TextStyle(color: Color(ConstColors.textInput)),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(ConstColors.bgInput),
                ),
                height: 35,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListRecipesTemplete(
                            pageTitle: "Filter",
                            listRecipesWidget: FilterPage(),
                          ),
                        ),
                      );
                    },
                    child: Image.asset(
                      "assets/Icons/filter.png",
                      height: 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8), // results
          Flexible(
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var doc in snapshots.data!.docs)
                        //
                          (doc['title'].toString().toLowerCase().contains(name.toLowerCase()) && name.isNotEmpty)
                              ? InkWell(
                            onTap: (){
                              final recipe = Recipes.fromJson(doc.data() as Map<String, dynamic>, doc.id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>RecipesDesciption(recipe: recipe) ));},
                            child: ListTile(
                              title: Text(
                                doc['title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                doc['Description'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage("assets/images/${doc['image']}"),
                              ),
                            ),
                          ): SizedBox(height: 0,)

                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


