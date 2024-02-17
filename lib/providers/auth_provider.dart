

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  GlobalKey<FormState>? regKey;
  GlobalKey<FormState>? formRegKey;
  GlobalKey<FormState>? formLoginKey;
  TextEditingController? emailCtrl;
  TextEditingController? passCtrl;
  TextEditingController? nameController;
    TextEditingController? dnameController;
  bool obsecureText = true;
  String? userName;

  void providerInit() {
    formKey = GlobalKey<FormState>();
    regKey = GlobalKey<FormState>();
    formRegKey= GlobalKey<FormState>();
    formLoginKey= GlobalKey<FormState>();
    emailCtrl = TextEditingController();
    passCtrl = TextEditingController();
    nameController = TextEditingController();
        dnameController = TextEditingController();
  }
  void toggleObsecure() {
    obsecureText = !obsecureText;
    notifyListeners();
  }

  void providerDispose() {
    emailCtrl = null;
    passCtrl = null;
    formKey = null;
    formRegKey=null;
    formLoginKey=null;
    regKey=null;
    nameController = null;
        dnameController = null;
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
      if (formRegKey?.currentState?.validate() ?? false) {
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




    } on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();
 print("errorrrrrr in sign up --------------$e");
  if (e.code == 'email-already-in-use') {
        OverlayToastMessage.show(
            widget: const ToastMessageWidget(
              message: 'Email already exists.',
              toastMessageStatus: ToastMessageStatus.failed,
            ));
      }
      else if (e.code == 'invalid-email') {
        OverlayToastMessage.show(
            widget: const ToastMessageWidget(
              message: 'Invalid email',
              toastMessageStatus: ToastMessageStatus.failed,
            ));
      }
      }
  }
  Future<void> UpdateUserProfilePic(BuildContext context,String image) async {
    var user = await FirebaseAuth.instance.currentUser;
    try {
      await user?.updatePhotoURL(image);
    notifyListeners();
    }catch(e){print("error in edit profile pic $e");}
  }

  Future<void> UpdateProfilePic(BuildContext context) async {

    OverlayLoadingProgress.start();
    var user = FirebaseAuth.instance.currentUser;
    var imageResult = await FilePicker.platform
        .pickFiles(
        type: FileType.image, withData: true);

    var ref = FirebaseStorage.instance
        .ref('user/${imageResult?.files.first.name}');

    if (imageResult?.files.first.bytes != null) {
      var uploadResult = await ref.putData(
          imageResult!.files.first.bytes!,
          SettableMetadata(contentType: 'image/png'));

      if (uploadResult.state == TaskState.success) {
        try {
          await user?.updatePhotoURL(
              await ref.getDownloadURL());
          notifyListeners();
          print(user?.photoURL);
        } catch (e) {
          print("error in edit profile pic $e");
        }
        OverlayToastMessage.show(textMessage:"Profile image updated successfully.");
        print(
            'Profile Picture updated successfully  ');
      }
    }

    OverlayLoadingProgress.stop();
  }

  Future<void> UpdateUserName(BuildContext context,String userName) async {
    
    var user = await FirebaseAuth.instance.currentUser;
    try {
      if (regKey?.currentState?.validate() ?? false) {
      await user!.updateDisplayName(userName);
      OverlayToastMessage.show(textMessage: 'Name Updated Successfully.');
      notifyListeners();
      }
    }catch(e){print("error in edit Display Name $e");}
  }
  Future<void> getUserName(BuildContext context) async {
    var user = await FirebaseAuth.instance.currentUser;
    try {
      userName= user!.displayName;

     // notifyListeners();
    }
    
    catch(e){print("error in edit Display Name $e");}
  }
  Future<void> LogIn(BuildContext context) async{
    try {
      print("login fun*************");
      if (formLoginKey?.currentState?.validate() ?? false) {
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
      } 
         else if (e.code == 'auth/email-already-exists') {
        OverlayToastMessage.show(
            widget: const ToastMessageWidget(
              message: 'auth/email-already-exists.',
              toastMessageStatus: ToastMessageStatus.failed,
            ));
      }
      else if (e.code == "user-disabled") {
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
      else if (e.code == "channel-error") {
        OverlayToastMessage.show(
            widget: const ToastMessageWidget(
              message: 'channel-error',
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