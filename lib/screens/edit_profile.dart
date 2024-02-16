import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:receipe/utilities/abstract_colors.dart';
import 'package:receipe/widgets/diplay_name.dart';
import 'package:receipe/widgets/profile_picture.dart';

import '../providers/auth_provider.dart';

class EditProfile extends StatefulWidget {
  EditProfile({
    super.key,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  void initState() {
    // TODO: implement initState
    Provider.of<AuthFirebaseProvider>(context, listen: false).providerInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<AuthFirebaseProvider>(
          builder: (context, authProvider, _) => 
          Form(
              key: authProvider.regKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Old Display Name
                  DisplayFullName(),

                  //Profile Pic
                  SizedBox(height: 190, child: ProfilePicture()),

                  //Display Name
                  TextFormField(
                    controller: authProvider.dnameController,
                    validator: (value) {
                                    if(value == Null || (value?.isEmpty ?? false)){
                                      return "Full Name is required.";
                                    }
                                    else
                                    {return null;}
                                  },
                    //FirebaseAuth.instance.currentUser!.displayName.toString()
                    decoration: InputDecoration(
                      focusColor: Colors.red,
                      fillColor: Color(ConstColors.bgInput),
                      filled: true,
                      hintText: 'Enter Full Name',
                      prefixIcon: Icon(
                        Icons.document_scanner,
                        color: Color(ConstColors.textInput),
                      ),
                      prefixIconColor: Color(ConstColors.textInput),
                      enabledBorder: ConstColors.textBoxBorder,
                      border: ConstColors.textBoxBorder,
                      hintStyle: const TextStyle(
                        color: Color(ConstColors.textInput),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(ConstColors.titleColors)),
                      onPressed: () {
                        authProvider.UpdateUserName(
                            context, authProvider.dnameController!.text);
                      },
                      child:
                          Text('Edit', style: TextStyle(color: Colors.white))),
                ],
              ))),
    );
  }
}
