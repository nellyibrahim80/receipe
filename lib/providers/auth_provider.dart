

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/home_page.dart';
import '../screens/login.dart';
import '../screens/register.dart';

class AuthFirebaseProvider extends ChangeNotifier{

  GlobalKey<FormState>? formKey;
  TextEditingController? emailCtrl;
  TextEditingController? passCtrl;
  TextEditingController? nameController;
  bool obsecureText = false;

  void providerInit() {
    formKey = GlobalKey<FormState>();
    emailCtrl = TextEditingController();
    passCtrl = TextEditingController();
    nameController = TextEditingController();
  }
  void toggleObsecure() {
    obsecureText = !obsecureText;
    notifyListeners();
  }

  void providerDispose() {
    emailCtrl = null;
    passCtrl = null;
    formKey = null;
    nameController = null;
    obsecureText = false;
  }

  void PassObsecure() {
    obsecureText = !obsecureText;
   // notifyListeners();
  }

  void openRegisterPage(BuildContext context) {
    providerDispose();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const RegisterPage()));
  }

  void openLoginPage(BuildContext context) {
    providerDispose();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  Future<void> signUp(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        var credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailCtrl!.text,
            password: passCtrl!.text);

        if (credentials.user != null) {
          await credentials.user?.updateDisplayName(nameController!.text);
          providerDispose();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomePage()));
        }
      }
    } catch (e) {}
  }
}