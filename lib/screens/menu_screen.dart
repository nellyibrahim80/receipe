

import 'dart:ffi';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:receipe/providers/auth_provider.dart';

import 'package:receipe/screens/edit_profile.dart';
import 'package:receipe/screens/favourit.dart';
import 'package:receipe/screens/home_page.dart';
import 'package:receipe/screens/ingredient.dart';

import 'package:receipe/utilities/abstract_colors.dart';
import 'package:receipe/widgets/diplay_name.dart';
import 'package:receipe/widgets/profile_picture.dart';
import '../widgets/menuItem.dart';
import 'recipe_list_templete.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AuthFirebaseProvider>(context,listen: false).getUserName(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Color(ConstColors.bgInput),
          leadingWidth: 90,
          toolbarHeight: 80,
          leading:ProfilePicture(),
          title:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
   DisplayFullName(),
        Padding(
                padding: EdgeInsets.only(top:8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListRecipesTemplete(
                      listRecipesWidget:EditProfile(),
                      pageTitle: "Edit Profile",
                    ),));
                  },
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 14.0,color:Color(ConstColors.textInput),),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(ConstColors.bgInput),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top:18.0,left:10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MenuItem(
                        LinkScreen: HomePage(),
                        menutitle: 'Home',
                        menuIcon: Icons.home),
                    MenuItem(
                        LinkScreen: ListRecipesTemplete(
                          listRecipesWidget: FavouritesPage(
                            whereCriteria: "favourite_users_ids",
                            collectionName: 'recipes',
                          ),
                          pageTitle: "Favourite",
                        ),
                        menutitle: 'Favourites',
                        menuIcon: Icons.favorite_border),
                    MenuItem(
                        LinkScreen: ListRecipesTemplete(
                          listRecipesWidget: FavouritesPage(
                            whereCriteria: "recently_viewd_users_ids",
                            collectionName: 'recipes',
                          ),
                          pageTitle: "Recently Viewed",
                        ),
                        menutitle: 'Recently Viewed',
                        menuIcon: Icons.play_arrow_outlined),
                    MenuItem(
                        LinkScreen: IngredientPage(),
                        menutitle: 'Ingredients',
                        menuIcon: Icons.food_bank_outlined),
                    ListTile(
                      horizontalTitleGap: 0,
                      minLeadingWidth: 15,
                      // minVerticalPadding: 20,
                      contentPadding: EdgeInsets.all(8),
                      title: TextButton(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sign Out",
                              style: TextStyle(color: Color(ConstColors.textSearchInput),fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Provider.of<AuthFirebaseProvider>(context,
                                  listen: false)
                              .SignOut(context);
                        },
                      ),
                      leading: Icon(Icons.logout,color:Color(ConstColors.textSearchInput)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
