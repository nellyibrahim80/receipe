import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return  SizedBox(
            width: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('${user?.photoURL}'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () async {
                      OverlayLoadingProgress.start();

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
                          print(
                              'Profile Picture updated successfully  ');
                        }
                      }

                      OverlayLoadingProgress.stop();
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
          );
  }
}