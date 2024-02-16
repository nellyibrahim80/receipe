import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe/screens/login.dart';

import '../providers/auth_provider.dart';
import '../utilities/abstract_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AuthFirebaseProvider>(context, listen: false).providerInit();
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
        child: Consumer<AuthFirebaseProvider>(builder: (context, value, child) {
          return Stack(
            children: [
              Form(
                key: value.formRegKey,
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
                       
                        child: Column(
                          children: [
                            TextFormField(
                              controller: value.nameController,
                               validator: (value) {
                                if (value == Null ||
                                    (value?.isEmpty ?? false)) {
                                  return "Full Name is required";
                                } else {
                                  return null;
                                }
                              },
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
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == Null ||
                                    (value?.isEmpty ?? false)) {
                                  return "Email is required";
                                } else {
                                  return null;
                                }
                              },
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
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: value.passCtrl,
                              validator: (value) {
                                if (value == null ||
                                    (value?.isEmpty ?? false)) {
                                  return 'Passwrord required.';
                                } else {
                                  print(value);
                                  return null;
                                }
                              },
                              obscureText: value.obsecureText,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Color(ConstColors.textInput),
                                  fontWeight: FontWeight.normal,
                                ),
                                suffixIcon: InkWell(
                                    onTap: () => value.toggleObsecure(),
                                    child: value.obsecureText
                                        ? Icon(Icons.visibility_off_outlined)
                                        : Icon(Icons.visibility_outlined)),
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: const Text("Register"),
                          onPressed: () {
                            value.signUp(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (MediaQuery.of(context).viewInsets.bottom == 0)
                Positioned.fill(
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already registered?",
                            style:
                                TextStyle(color: Color(ConstColors.whiteColor)),
                          ),
                          TextButton(
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Color(ConstColors.titleColors)),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginPage()));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
