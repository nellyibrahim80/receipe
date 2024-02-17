import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return  Consumer<AuthFirebaseProvider>(
        builder: (context, authProvValu, child) { return SizedBox(
            width: 150,
            child:   Stack(
              fit: StackFit.expand,
              children: [
          CircleAvatar(
  backgroundImage: NetworkImage(
    FirebaseAuth.instance.currentUser?.photoURL ?? "https://firebasestorage.googleapis.com/v0/b/recipe-33f86.appspot.com/o/user%2FWhatsApp%20Image%202024-02-16%20at%2023.02.56_051904a9.jpg?alt=media",
  ),
),

                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () async {
                      await authProvValu.UpdateProfilePic(context);
                    /*  OverlayLoadingProgress.start();

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
                            setState(() {});
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

                     */
                    },
                    child: Container(
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            );}
    );
  }
}