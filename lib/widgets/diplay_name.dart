import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe/providers/auth_provider.dart';

class DisplayFullName extends StatefulWidget {
  final FontWeight? myFont;
  const DisplayFullName( {super.key,required this.myFont});
  @override
  State<DisplayFullName> createState() => _DisplayFullNameState();
}

class _DisplayFullNameState extends State<DisplayFullName> {
  @override
  Widget build(BuildContext context) {
    return        Consumer<AuthFirebaseProvider>(
          builder: (context, authProvValu, child) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
Text(
          FirebaseAuth.instance.currentUser!.displayName.toString(),
              //"${authProvValu.userName}",
  //"${ Provider.of<AuthFirebaseProvider>(context,listen: true).userName}",
                style: TextStyle( fontSize: 16.0, fontWeight: widget.myFont),),

          ],
        ),);
  }
}