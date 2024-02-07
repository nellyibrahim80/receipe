import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:receipe/providers/auth_provider.dart';
import 'package:receipe/screens/favourit.dart';
import 'package:receipe/screens/home_page.dart';
import 'package:receipe/screens/ingredient.dart';
import 'package:receipe/utilities/abstract_colors.dart';
import 'package:receipe/widgets/recipe_from_query.dart';

import '../widgets/menuItem.dart';
import 'recipe_list_templete.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
        backgroundColor:  Color(ConstColors.bgInput),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color:  Color(ConstColors.bgInput),),
              accountName: Text("${user?.displayName}"),
              accountEmail: Text("${user?.email}"),
              currentAccountPicture: InkWell(
                onTap: () {}, // Set the edit photo callback function
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${user?.photoURL}'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () async {
                          OverlayLoadingProgress.start();

                          var imageResult = await FilePicker.platform
                              .pickFiles(type: FileType.image, withData: true);

                          var ref = FirebaseStorage.instance
                              .ref('user/${imageResult?.files.first.name}');

                          if (imageResult?.files.first.bytes != null) {
                            var uploadResult = await ref.putData(
                                imageResult!.files.first.bytes!,
                                SettableMetadata(contentType: 'image/png'));

                            if (uploadResult.state == TaskState.success) {
                              try {
                                await user?.updatePhotoURL(
                                    await ref.getDownloadURL());
                                setState(() {});
                                print(user?.photoURL);
                              } catch (e) {
                                print("error in edit profile pic $e");
                              }
                              print('Profile Picture updated successfully  ');
                            }
                          }

                          OverlayLoadingProgress.stop();
                        },
                        child: Container(
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ), 
            MenuItem(LinkScreen: HomePage(), menutitle: 'Home',menuIcon: Icons.home),
            MenuItem(LinkScreen:ListRecipesTemplete(listRecipesWidget:  FavouritesPage(whereCriteria: "favourite_users_ids", collectionName: 'recipes',), pageTitle: "Favourite" ,), menutitle: 'Favourites',menuIcon: Icons.favorite_border),
            MenuItem(LinkScreen: IngredientPage(), menutitle: 'Ingredients',menuIcon: Icons.food_bank_outlined),
      SizedBox(
        width: 180,
            child:ListTile(
              title: TextButton(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
                onPressed: () {
                  Provider.of<AuthFirebaseProvider>(context, listen: false)
                      .SignOut(context);
                },
              ),
              leading: Icon(Icons.logout),
            ),
      )
          ],
        ),
      ),
    );
  }

 
}
