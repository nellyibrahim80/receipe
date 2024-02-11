import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe/providers/recipe_fire_provider.dart';
import 'package:receipe/screens/recipe_list_templete.dart';
import 'package:receipe/utilities/abstract_colors.dart';
import 'package:receipe/widgets/recipe_from_query.dart';


class SeeAllHeader extends StatelessWidget {
  final String HeaderTitle;
  const SeeAllHeader({required this.HeaderTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(HeaderTitle,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ),
        ),
        InkWell(
          onTap: (){
            var targetRecipe=Provider.of<RecipeFireProvider>(context, listen: false).displayRecipes;
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListRecipesTemplete(listRecipesWidget:  RecipeFromQuery(Targetrecipe: targetRecipe,condition: "",whereCriteria: "all"), pageTitle: "Recipee",)));},
          child: Text("See All",
              style: TextStyle(
                color: Color(ConstColors.titleColors),
                fontSize: 18,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        )
      ],
    );
  }
}
