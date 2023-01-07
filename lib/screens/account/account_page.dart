import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:epiece_shopping_app/base/go_to_sign_in_page.dart';
import 'package:epiece_shopping_app/components/colors.dart';
import 'package:epiece_shopping_app/controllers/auth_controller.dart';
import 'package:epiece_shopping_app/controllers/cart_controller.dart';
import 'package:epiece_shopping_app/controllers/location_controller.dart';
import 'package:epiece_shopping_app/controllers/user_controller.dart';
import 'package:epiece_shopping_app/data/api/firebase_api.dart';
import 'package:epiece_shopping_app/models/firebase_file.dart';
import 'package:epiece_shopping_app/routes/route_helper.dart';
import 'package:epiece_shopping_app/screens/account/profilePicture.dart';
import 'package:epiece_shopping_app/uitls/app_dimensions.dart';
import 'package:epiece_shopping_app/widgets/account_widgets.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import '../../base/custom_image.dart';
import '../../controllers/splash_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  _loadUserInfo() async {
    //futureFiles = FirebaseApi.listAll('files/');
    await Get.find<LocationController>().getAddressList();
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      var address = Get.find<LocationController>().addressList[0];
      await Get.find<LocationController>().saveUserAddress(address);
      print("I am in home page ............");
    } else {
      print("addresslist ferghaa");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
    late Future<List<FirebaseFile>> futureFiles;

    if (_isLoggedIn && Get.find<LocationController>().addressList.isEmpty) {
      futureFiles = FirebaseApi.listAll('UserImage/');
      Get.find<UserController>().getUserInfo();
      // Get.find<LocationController>().getAddressList();
      _loadUserInfo();
      print(".........");
    } else {
      print("empty " + _isLoggedIn.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: AppColors.mainColor,
      ),
     // backgroundColor: Colors.white10,
      body: Container(
        color:Colors.white10,
        margin: Dimensions.isWeb
            ? EdgeInsets.only(
                left: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                right: Dimensions.MARGIN_SIZE_EXTRA_LARGE)
            : EdgeInsets.all(0),
        child: GetBuilder<UserController>(builder: (userController) {
          //var path = '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl}/${userController.userInfoModel?.image}';
          //print(path);
          String? fName = userController.userInfoModel?.fName;
          //String userToken = Get.find<AuthController>().getUserToken();
          String userToken = "";
          var pathStorage = storage.ref('imageUser/$userToken').getDownloadURL();
          //var path2 = '/${(Get.find<UserController>().userInfoModel != null && Get.find<AuthController>().isLoggedIn()) ? Get.find<UserController>().userInfoModel?.image : "assets/image/forget_password.png"}';
          //path2 = "http://127.0.0.1:8000/storage/profile" + path2;
          //print (path2);

          return (_isLoggedIn)
              ?
                   Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        ProfilePic(),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  AccountWidgets(
                                      fName??"name not found",
                                      icon: Icons.person,
                                      backgroundColor: AppColors.mainColor),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  AccountWidgets(
                                      userController.userInfoModel?.phone??"Phone not found",
                                      icon: Icons.phone,
                                      backgroundColor: AppColors.yellowColor),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  AccountWidgets(
                                      userController.userInfoModel?.email??"Error of getting Email",
                                      icon: Icons.email,
                                      backgroundColor: AppColors.yellowColor),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GetBuilder<LocationController>(
                                      builder: (locationController) {
                                    if (_isLoggedIn &&
                                        Get.find<LocationController>()
                                            .addressList
                                            .isEmpty) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              RouteHelper.getAddAddressRoute());
                                        },
                                        child: AccountWidgets(
                                            "Fill in your address",
                                            icon: Icons.location_on,
                                            backgroundColor:
                                                AppColors.yellowColor),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              RouteHelper.getAddAddressRoute());
                                        },
                                        child: AccountWidgets("Address",
                                            icon: Icons.location_on,
                                            backgroundColor:
                                                AppColors.yellowColor),
                                      );
                                    }
                                  }),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                          RouteHelper.getContactUsRoute());
                                    },
                                    child: AccountWidgets("Contact us",
                                        icon: Icons.message,
                                        backgroundColor: Colors.lightGreen),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Get.toNamed(RouteHelper.getUpdateProfile());
                                      },
                                      child: AccountWidgets("Edit",
                                          icon: Icons.edit,
                                          backgroundColor: Colors.lightBlue)),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .isLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<CartController>()
                                              .clearCartList();
                                          Get.find<LocationController>()
                                              .clearAddressList();
                                          Get.offAllNamed(
                                              RouteHelper.getInitialRoute());
                                        }
                                      },
                                      child: AccountWidgets("Log out",
                                          icon: Icons.logout,
                                          backgroundColor: Colors.redAccent)),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )

              : GoToSignInPage();

        }),
      ),
    );
  }
}
