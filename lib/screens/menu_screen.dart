import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:receipe/screens/favourit.dart';
import 'package:receipe/screens/ingredient.dart';

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
        body: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("${user?.displayName}"),
              accountEmail: Text("${user?.email}"),
              currentAccountPicture: InkWell(
                onTap: () {}, // Set the edit photo callback function
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('user/${user?.photoURL}'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () async { OverlayLoadingProgress.start();

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
                                  ref.getDownloadURL().toString());
                              setState(() {

                              });
                            }catch(e){print("error in edit profile pic $e");}
                            print(
                                'Profile Picture updated successfully ');
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
            ListTile(
              title: TextButton(
                child: Text(
                  "Ingredient",
                  style: TextStyle(color: Colors.black87),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IngredientPage()));
                },
              ),
              leading: Icon(Icons.food_bank_outlined),
            ),
            ListTile(
              title: TextButton(
                child: Text(
                  "Favourit",
                  style: TextStyle(color: Colors.black87),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavouritesPage()));
                },
              ),
              leading: Icon(Icons.favorite),
            ),
          ],
        ),
      ),
    );
  }
}
