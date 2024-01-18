import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utilities/abstract_colors.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  
  void initState() {
    // TODO: implement initState
    Provider.of<AuthFirebaseProvider>(context).providerInit();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 500,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/images/frying-pan-empty-assorted-spices.png"),
                fit: BoxFit.cover)),
        child: Consumer<AuthFirebaseProvider>(
          builder: (context,value,child) {
            return Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Form (
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //AssetImage("assets/images/Logo.png")
                        Image.asset(
                          "assets/images/logo.png",
                          width: 250,
                        ),
                        const Text("Register",
                            style: TextStyle(
                                color: Color(ConstColors.whiteColor),
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                    
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: 300,
                            height: 200,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: value.nameController,
                                  decoration: const InputDecoration(
                                    hintText: "Full Name",
                                    hintStyle: TextStyle(
                                      color: Color(ConstColors.textInput),
                                      fontWeight: FontWeight.normal,
                                    ),
                                    icon: Icon(Icons.person),
                                    iconColor: Color(ConstColors.textInput),
                                  ),
                                  style: const TextStyle(
                                      color: Color(ConstColors.textInput)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: value.emailCtrl,
                                  decoration: const InputDecoration(
                                    hintText: "Email Address",
                                    hintStyle: TextStyle(
                                      color: Color(ConstColors.textInput),
                                      fontWeight: FontWeight.normal,
                                    ),
                                    icon: Icon(Icons.email_outlined),
                                    iconColor: Color(ConstColors.textInput),
                                  ),
                                  style: const TextStyle(
                                      color: Color(ConstColors.textInput)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: value.passCtrl,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      color: Color(ConstColors.textInput),
                                      fontWeight: FontWeight.normal,
                                    ),
                                    suffixIcon: Icon(Icons.visibility_off_outlined),
                                    suffixIconColor: Color(ConstColors.textInput),
                                    icon: Icon(Icons.lock_outline_rounded),
                                    iconColor: Color(ConstColors.textInput),
                                  ),
                                  style: const TextStyle(
                                      color: Color(ConstColors.textInput)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          child: const Text("Log In"),
                          onPressed: () {
                    
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Already registered?",
                        style: TextStyle(color: Color(ConstColors.whiteColor)),
                      ),
                      TextButton(
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Color(ConstColors.titleColors)),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RegisterPage()));
                        },
                      )
                    ],
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
