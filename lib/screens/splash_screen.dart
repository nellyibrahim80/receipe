import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:receipe/screens/login.dart';
import 'package:receipe/services/shared_pref.dart';
import 'package:receipe/utilities/abstract_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAuthUser();
  }

  void initAuthUser() async{
    var authFirebase=FirebaseAuth.instance;
    await authFirebase.authStateChanges().listen((user) {
      if(user!=null){
        print("loged in user");
        // if (SharedPrefClass.CheckLogging()) { //with shared pref abstract class
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage(),));
      }
      else {
        print("not logged in user");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage(),));
      }
    });
  }
void sharedPrefinit() async {
    await Future.delayed(Duration(seconds: 3));

    if(GetIt.I.get<SharedPreferences>().getBool("isLogged") ?? false){
 // if (SharedPrefClass.CheckLogging()) { //with shared pref abstract class
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage(),));
  }
  else {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage(),));
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 500,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bgimage.png"),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //AssetImage("assets/images/Logo.png")
            Image.asset(
              "assets/images/logo.png",
              width: 250,
            ),
            const Text("Cooking Done The Easy way",
                style: TextStyle(color: Color(ConstColors.whiteColor))),
            const CircularProgressIndicator(),
            const SizedBox(
              height: 220,
            ),
            ElevatedButton(
              style: ButtonStyle(),
              child: Text("Register"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                },
                child: Text("Sign In"))
          ],
        ),
      ),
    );
  }
}
