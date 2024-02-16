
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:receipe/providers/auth_provider.dart';
import 'package:receipe/screens/register.dart';

import '../utilities/abstract_colors.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AuthFirebaseProvider>(context,listen: false).providerInit();
    super.initState();
  }

  @override
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
          builder: (context,providerValue,child) {
            return Form(
              key: providerValue.formLoginKey,
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
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
                                  validator: (value) {
                                    if(value == Null || (value?.isEmpty ?? false)){
                                      return "Email is required";
                                    }
                                    else
                                    {return null;}
                                  },

                                  controller: providerValue.emailCtrl,
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
                                  validator: (value) {
                                    if(value==Null || (value?.isEmpty ?? false)){
                                      return ("Pass is req");
                                  }
                                    },
                                  controller: providerValue.passCtrl,

                                  obscureText: providerValue.obsecureText,
                                  decoration:  InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      color: Color(ConstColors.textInput),
                                      fontWeight: FontWeight.normal,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () => providerValue.toggleObsecure(),
                                        child: providerValue.obsecureText? Icon(Icons.visibility_off_outlined):Icon(Icons.visibility_outlined)),
                                    suffixIconColor: Color(ConstColors.textInput),
                                    icon:Icon(Icons.lock_outline_rounded),
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
                            providerValue.LogIn(context);
                            // if (userNameCtrl.text == "nelly" &&
                            //     passCtrl.text == "1122") {
                            //   //SharedPrefClass.pref.setBool("isLogged", true);
                            //   //SharedPrefClass.pref.setString("Email", userNameCtrl.text);
                            //
                            //   GetIt.I
                            //       .get<SharedPreferences>()
                            //       .setBool("isLogged", true);
                            //   GetIt.I
                            //       .get<SharedPreferences>()
                            //       .setString("Email", userNameCtrl.text);
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => HomePage()));
                            // } else {
                            //   print("${userNameCtrl.text} ${passCtrl.text}");
                            //   userNameCtrl.clear();
                            //   passCtrl.clear();
                            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //       content: Text(
                            //           "Invalid User name user:nelly pass:1122")));
                            // }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(color: Color(ConstColors.whiteColor)),
                        ),
                        TextButton(
                          child: Text(
                            "Register",
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
              ),
            );
          }
        ),
      ),
    );
  }
}
