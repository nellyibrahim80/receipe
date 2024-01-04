import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:receipe/services/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utilities/abstract_colors.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameCtrl=TextEditingController();
  TextEditingController passCtrl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 500,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/frying-pan-empty-assorted-spices.png"),
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
            const Text("Sign In",
                style: TextStyle(color: Color(ConstColors.whiteColor),fontWeight: FontWeight.bold,fontSize: 18)),

             Padding(
               padding: const EdgeInsets.all(20.0),
               child: SizedBox(

                 width: 300,
                 height: 200,
                 child: Column(
                   children: [
                     TextFormField(
                       controller: userNameCtrl,
                       decoration: const InputDecoration(
                         hintText: "Email Address",
                         hintStyle:  TextStyle(
                             color:Color(ConstColors.textInput),
                           fontWeight: FontWeight.normal,
                         ),
                         icon: Icon(Icons.email_outlined),
                         iconColor: Color(ConstColors.textInput),

                       ),


                       style: const TextStyle(color: Color(ConstColors.textInput)),


                     ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: passCtrl,
                       obscureText: true,
                       decoration: const InputDecoration(
                         hintText: "Password",
                         hintStyle:  TextStyle(
                           color:Color(ConstColors.textInput),
                           fontWeight: FontWeight.normal,
                         ),
                         suffixIcon: Icon(Icons.visibility_off_outlined),
                         suffixIconColor: Color(ConstColors.textInput),
                         icon: Icon(Icons.lock_outline_rounded),
                         iconColor: Color(ConstColors.textInput),

                       ),


                       style: const TextStyle(color: Color(ConstColors.textInput)),


                     ),
                   ],
                 ),

               ),
             ),
            ElevatedButton(

              child: const Text("Log In"),
              onPressed: () {
                if (userNameCtrl.text=="nelly" && passCtrl.text=="1122") {
                  //SharedPrefClass.pref.setBool("isLogged", true);
                  //SharedPrefClass.pref.setString("Email", userNameCtrl.text);

                  GetIt.I.get<SharedPreferences>().setBool("isLogged", true);
                  GetIt.I.get<SharedPreferences>().setString("Email", userNameCtrl.text);
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) =>  HomePage()));
                }
                else
                  {
                    print("${userNameCtrl.text} ${passCtrl.text}");
                    userNameCtrl.clear();
                    passCtrl.clear();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid User name user:nelly pass:1122")));
                  }
              },
            ),

          ],
        ),
      ),
    );
  }
}
