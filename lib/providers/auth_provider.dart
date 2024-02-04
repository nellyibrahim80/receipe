

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:receipe/screens/splash_screen.dart';

import '../screens/home_page.dart';
import '../screens/login.dart';
import '../screens/register.dart';
import '../utilities/toest_message_status.dart';
import '../widgets/ToastMessage.dart';

class AuthFirebaseProvider extends ChangeNotifier{

  GlobalKey<FormState>? formKey;
  TextEditingController? emailCtrl;
  TextEditingController? passCtrl;
  TextEditingController? nameController;
  bool obsecureText = true;

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
        OverlayLoadingProgress.start();
        var credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailCtrl!.text,
            password: passCtrl!.text);

        if (credentials.user != null) {
          await credentials.user?.updateDisplayName(nameController!.text);
          OverlayLoadingProgress.stop();
          providerDispose();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomePage()));
        }
        OverlayLoadingProgress.stop();
      }
    } catch (e) {OverlayLoadingProgress.stop();}
  }
  Future<void> UpdateUserProfilePic(BuildContext context,String image) async {
    var user = await FirebaseAuth.instance.currentUser;
    try {
      await user?.updatePhotoURL(image);
    notifyListeners();
    }catch(e){print("error in edit profile pic $e");}
  }
  Future<void> LogIn(BuildContext context) async{
    try {
      print("login fun*************");
      if (formKey?.currentState?.validate() ?? false) {
        print("login fun**++++++++++++*");
        OverlayLoadingProgress.start();
        var firebaseInstance = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailCtrl!.text, password: passCtrl!.text);
        if (firebaseInstance.user != Null) {
          OverlayLoadingProgress.stop();
          providerDispose();
          OverlayToastMessage.show(textMessage: 'Login Successfully.');
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomePage()));
        }
      }
    }
          on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();

      if (e.code == 'user-not-found') {
        OverlayToastMessage.show(
          widget: const ToastMessageWidget(
            message: 'user not found',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      } else if (e.code == 'wrong-password') {
        OverlayToastMessage.show(
            widget: const ToastMessageWidget(
              message: 'Wrong password provided for that user.',
              toastMessageStatus: ToastMessageStatus.failed,
            ));
      } else if (e.code == "user-disabled") {
        OverlayToastMessage.show(
            widget: const ToastMessageWidget(
              message: 'This email Account was disabled',
              toastMessageStatus: ToastMessageStatus.failed,
            ));
      } else if (e.code == "invalid-credential") {
        OverlayToastMessage.show(
            widget: const ToastMessageWidget(
              message: 'invalid-credential',
              toastMessageStatus: ToastMessageStatus.failed,
            ));
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(textMessage: 'General Error $e');
    }
  }
 void SignOut(BuildContext context){
    FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement
      (context, MaterialPageRoute(builder:(context)=> SplashScreen())));
 }
  
}