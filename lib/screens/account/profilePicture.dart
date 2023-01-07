import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:epiece_shopping_app/base/custom_image.dart';
import 'package:epiece_shopping_app/components/colors.dart';
import 'package:epiece_shopping_app/controllers/auth_controller.dart';
import 'package:epiece_shopping_app/controllers/user_controller.dart';
import 'package:epiece_shopping_app/data/api/firebase_api.dart';
import 'package:epiece_shopping_app/models/firebase_file.dart';

class ProfilePic extends StatefulWidget {
  @override
  State<ProfilePic> createState() => _ProfilePic();
}

class _ProfilePic extends State<ProfilePic> {
  late Future<List<FirebaseFile>> futureFiles;
  late UserController userController;
  late Reference ref ;
  late bool _isLoggedIn;

  String profilePicLink = "";
  @override
  void initState() {
    super.initState();

    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    Get.find<UserController>().initData();
    userController = Get.find<UserController>();
    ref = FirebaseStorage.instance
    //.ref("UserImage").child("profilepic.jpg");
        .ref("UserImage/${userController.userInfoModel!.id.toString()}.jpg");

    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
      });
    });
    //futureFiles = FirebaseApi.listAll('UserImage/');
  }

  @override
  Widget build(BuildContext context) => Container(
    width: 150,
    height: 150,
    child:Builder(
      builder: (context) {
        if (profilePicLink.isEmpty) {
            return ClipOval(
                child: CustomImage(
                  image: "https://firebasestorage.googleapis.com/v0/b/epiece-30341.appspot.com/o/UserImage%2Fprofile%20user.png?alt=media&token=feb4de3a-215c-4550-a853-01f5206e41cb",
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                  placeholder: '',
                )
            );

        } else {
          return ClipOval(
              child: CustomImage(
                image: profilePicLink,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
                placeholder: '',
              )
          );
        }
      }
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(75),
        color: AppColors.mainColor),
  );

/*
  @override
  Widget build(BuildContext context) => Container(
    width: 150,
    height: 150,
    child:FutureBuilder<List<FirebaseFile>>(
      future: futureFiles,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Some error occurred!'));
              } else {
                final files = snapshot.data!;
                return ClipOval(
                    child: CustomImage(
                      image: files[files.length-1].url,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                      placeholder: '',
                    )
                );
              };
          };
      }  //child:
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(75),
        color: AppColors.mainColor),
  );*/



}