import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:receipe/screens/edit_profile.dart';
import 'package:receipe/screens/recipe_list_templete.dart';

import 'package:receipe/utilities/abstract_colors.dart';
import 'package:receipe/widgets/diplay_name.dart';
import 'package:receipe/widgets/profile_picture.dart';
import '../providers/auth_provider.dart';

class SettingPage extends StatefulWidget {
  SettingPage({
    super.key,
  });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
   bool lang=false;
  void initState() {
    // TODO: implement initState
    Provider.of<AuthFirebaseProvider>(context, listen: false).providerInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
 
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Card(
              color: Color(ConstColors.bgInput),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.all(10),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  minVerticalPadding: 20,
                  horizontalTitleGap: 0,
                  minLeadingWidth:50,
                  titleAlignment: ListTileTitleAlignment.top,
                  contentPadding: EdgeInsets.all(0),
                  leading: const Icon(Icons.language_sharp,size: 35,),
                  title: Text("Language"),
                  trailing: TextButton(
                    onPressed: () {  setState(() {
      // Toggle the language state
      lang = !lang;
        print("Language toggled: $lang");
    });
                    },
                    child: Text((lang) ?   "عربي":"English",
                      style: TextStyle(color: Color(ConstColors.titleColors)),
                    ),
                  ),
                ),
              )),
              ConstColors.line,
              Row(
                children: [
                  Text("Profile Information",style: TextStyle(fontSize: 22),),
               
               ],
              ),
              Card(
              color: Color(ConstColors.bgInput),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.all(10),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      minVerticalPadding: 20,
                      horizontalTitleGap: 0,
                      minLeadingWidth:50,
                      titleAlignment: ListTileTitleAlignment.top,
                      contentPadding: EdgeInsets.all(0),
                      leading: const Icon(Icons.person,size: 35,),
                      title: Text("Full Name"),
                      trailing: TextButton(
                        onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListRecipesTemplete(
                              listRecipesWidget: EditProfile(),
                              pageTitle: "Edit Profile",
                            ),
                          ));},
                        child: Text(
                          "Edit",
                          style: TextStyle(color: Color(ConstColors.titleColors)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ConstColors.line,
                    ),
                     ListTile(
                      minVerticalPadding: 20,
                      horizontalTitleGap: 0,
                      minLeadingWidth:50,
                      titleAlignment: ListTileTitleAlignment.top,
                      contentPadding: EdgeInsets.all(0),
                      leading: const Icon(Icons.account_box_outlined,size: 35,),
                      title: Text("Profile Picture"),
                      trailing: TextButton(
                        onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListRecipesTemplete(
                              listRecipesWidget: EditProfile(),
                              pageTitle: "Edit Profile",
                            ),
                          ));},
                        child: Text(
                          "Edit",
                          style: TextStyle(color: Color(ConstColors.titleColors)),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
                
        ],
      ),
    );
  }
}
