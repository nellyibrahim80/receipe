import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:receipe/models/recipe.dart';
import 'package:receipe/utilities/abstract_colors.dart';

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
            builder: (context, authProvider, _) => Form(
                key: authProvider.regKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    TextFormField(
                      controller: authProvider.nameController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(ConstColors.textInput))),
                          fillColor: Color(ConstColors.bgInput),
                          filled: true,
                          hintStyle: TextStyle(color: Color(ConstColors.textInput)),
                          hintText: 'name',
                          prefixIcon: Icon(
                            Icons.document_scanner,
                            color: Color(ConstColors.textInput),
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(

                            backgroundColor: Color(ConstColors.titleColors)),
                        onPressed: () {
                          authProvider.UpdateUserName(context, authProvider.nameController!.text);

                        },
                        child: Text('Edit',
                            style: TextStyle(color: Colors.white))),

                  ],
                ))),

    );
  }
}
