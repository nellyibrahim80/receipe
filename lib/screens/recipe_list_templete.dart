import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:receipe/models/recipe.dart';
import 'package:receipe/widgets/Search.dart';
import 'package:receipe/widgets/recipe_from_query.dart';
import '../providers/recipe_fire_provider.dart';
import '../utilities/abstract_colors.dart';
import '../widgets/recommended.dart';
import '../widgets/sub_header.dart';
import 'menu_screen.dart';

class ListRecipesTemplete extends StatefulWidget {
  //final List<Recipes> Targetrecipe;
  final String? pageTitle;
  final Widget listRecipesWidget;
  const ListRecipesTemplete({super.key,this.pageTitle, required this.listRecipesWidget});

  @override
  State<ListRecipesTemplete> createState() => _ListRecipesTempleteState();
}

class _ListRecipesTempleteState extends State<ListRecipesTemplete> {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();



  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      disableDragGesture: true,
      mainScreenTapClose: true,
      menuBackgroundColor:  Color(ConstColors.bgInput),
     // mainScreenOverlayColor: Color(ConstColors.bgInput),
     // menuScreenOverlayColor: Color(ConstColors.bgInput),
      menuScreen: MenuScreen(),
      mainScreen: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: Image.asset(
                'assets/Icons/menu.png',
                width: 80,
                height: 80,
              ),
              onPressed: () {
                // Your onPressed logic here
                zoomDrawerController.toggle!();
              },
            ),
          ),
          title: Text(widget.pageTitle.toString()),
        ),
        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if(widget.pageTitle != "Edit Profile")SearchWidget(),
                widget.listRecipesWidget
              ],
            ),
          ),
        )
      ),
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      drawerShadowsBackgroundColor: Colors.grey.shade300,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}
