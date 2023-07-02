import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/widgets/appbar.dart';
import 'package:fashionstore/widgets/main_heading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shimmer_animation/shimmer_animation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();

  String? profileImage;
  bool enableTextField = false;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    _nameController.text = user!.displayName!;
    profileImage = user!.photoURL ??
        "https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_960_720.png";
    super.initState();
  }

  User? user;
  @override
  Widget build(BuildContext context) {
    String email = FirebaseAuth.instance.currentUser!.email!;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 10, top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Appbar(goBack: true),
                khieght10,
                const MainHeading(
                  text: 'Profile',
                ),
                khieght10,
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.grey[300],
                        child: ClipOval(
                            child: GestureDetector(
                          onTap: () async {
                            final pickedFile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            if (pickedFile == null) {
                              return;
                            } else {
                              File file = File(pickedFile.path);

                              await uploadImage(file, email);
                            }
                          },
                          child: CachedNetworkImage(
                            imageUrl: profileImage!,
                            placeholder: (context, url) => Shimmer(
                              color: Colors.black,
                              child: Container(
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                              ),
                            ),
                          ),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          width: 350,
                          height: 50,
                          child: TextField(
                            onSubmitted: (value) {
                              user!.updateDisplayName(
                                  _nameController.text.trim());
                            },
                            controller: _nameController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.text_fields,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: 'Enter Name',
                              filled: true,
                              fillColor: Colors.brown[100],
                              isDense: true, // Added this
                              contentPadding: const EdgeInsets.all(18),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            enableTextField = !enableTextField;
                          });
                          if (!enableTextField) {
                            user!.updateDisplayName(_nameController.text);
                            Fluttertoast.showToast(
                              msg: 'Your Name Updated',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(350, 55),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 10,
                        ),
                        icon: const Icon(
                          Icons.update,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  uploadImage(File file, String email) async {
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    firebase_storage.Reference ref = storage.ref().child('pfp/$email');

    firebase_storage.UploadTask task = ref.putFile(file);

    await task;
    String imageUrl = await ref.getDownloadURL();
    final User? user = FirebaseAuth.instance.currentUser;
    await user!.updatePhotoURL(imageUrl);
    setState(() {
      profileImage = imageUrl;
    });
  }
}
