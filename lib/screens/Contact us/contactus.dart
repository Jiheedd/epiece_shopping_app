import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:epiece_shopping_app/base/custom_button.dart';
import 'package:epiece_shopping_app/base/custom_image.dart';
import 'package:epiece_shopping_app/base/custom_snackbar.dart';
import 'package:epiece_shopping_app/base/go_to_sign_in_page.dart';
import 'package:epiece_shopping_app/components/colors.dart';
import 'package:epiece_shopping_app/components/custom_surfix_icon.dart';
import 'package:epiece_shopping_app/controllers/auth_controller.dart';
import 'package:epiece_shopping_app/controllers/splash_controller.dart';
import 'package:epiece_shopping_app/controllers/user_controller.dart';
import 'package:epiece_shopping_app/models/user_info_model.dart';
import 'package:epiece_shopping_app/routes/route_helper.dart';
import 'package:epiece_shopping_app/uitls/app_dimensions.dart';
import 'package:epiece_shopping_app/uitls/size_config.dart';
import 'package:epiece_shopping_app/uitls/styles.dart';
import 'package:epiece_shopping_app/widgets/app_text_field.dart';
import 'package:image_picker/image_picker.dart';


class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final TextEditingController message = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late bool _isLoggedIn;
  String imageLink = "";
  late bool _isCartChanged;
  String? name, email;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _isCartChanged = false;
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    Get.find<UserController>().initData();
  }

  void pickUploadCartGrisePic(UserController userController) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );
    Reference ref = FirebaseStorage.instance
        .ref("contactUs/").child(userController.userInfoModel!.id.toString()+".jpg");
    //    .ref("UserImage/");

    await ref.putFile(File(image!.path));

    print (image);
    ref.getDownloadURL().then((value) async {
      setState(() {
        imageLink = value;
        print(value);
        _isCartChanged = true;
      });
    });
  }


  void validation(UserController userController) async {
    String _firstName = _firstNameController.text.trim();
    String _email = _emailController.text.trim();
    String _phoneNumber = _phoneController.text.trim();
    if (_firstName.isEmpty) {
      showCustomSnackBar('enter_your_first_name');
    }else if (_email.isEmpty) {
      showCustomSnackBar('enter_email_address');
    }else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar('enter_a_valid_email_address');
    }else if (_phoneNumber.isEmpty) {
      showCustomSnackBar('enter_phone_number');
    }else if (_phoneNumber.length < 6) {
      showCustomSnackBar('enter_a_valid_phone_number');
    } else {
      DateTime currentTime = DateTime.now();
      String docId = Get.find<AuthController>().getUserToken()+currentTime.toString() ;
      FirebaseFirestore.instance.collection("Message").doc(docId).set({
        "Name": _firstName,
        "Email": _email,
        "Phone number": _phoneNumber,
        "Message": message.text,
        "message_id": docId,
        "image": imageLink,
      });
    }
  }

  Widget _buildSingleFlied({String? name}) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name??"name",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text("Contact us"),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(onPressed: ()=>Get.offNamed(RouteHelper.getAccountPage()),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height:800,
        child: GetBuilder<UserController>(builder: (userController) {

          if(userController.userInfoModel != null && _phoneController.text.isEmpty) {
            _firstNameController.text = userController.userInfoModel?.fName ?? '';
            _phoneController.text = userController.userInfoModel?.phone ?? '';
            _emailController.text = userController.userInfoModel?.email ?? '';
          }

          return _isLoggedIn ? userController.userInfoModel != null ? Column(
            // print("Image "+('${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl}/${userController.userInfoModel?.image}').toString());
            children: [
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    physics:BouncingScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'Your name',
                            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          AppTextField(hintText: "Name", textController: _firstNameController, icon: Icons.drive_file_rename_outline,textInputType: TextInputType.name),
                          //SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                          Text(
                            'email',
                            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          AppTextField(hintText: "Email", textController: _emailController, icon: Icons.email,textInputType: TextInputType.emailAddress),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                          Text(
                            'phone',
                            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          AppTextField(hintText: "Phone", textController: _phoneController, icon: Icons.phone,textInputType: TextInputType.phone),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                          Text(
                            'message',
                            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 7,
                                      offset: Offset(1, 1),
                                      color: Colors.grey.withOpacity(0.2)
                                  )
                                ]
                            ),
                            child: TextFormField(
                              controller: message,
                              textInputAction: TextInputAction.done,
                              expands: true,
                              maxLines: null,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: InputDecoration(
                                  hintText: "Write your message",
                                  hintStyle: TextStyle(
                                    color: AppColors.signColor,
                                    fontSize: getProportionateScreenWidth(13),
                                  ),

                                  suffixIcon: CustomSurffixIcon(icon: Icons.message),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: AppColors.mainColor,
                                          width: 1.0
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 1.0
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                          Center(
                            child: Builder(
                                builder: (context) {
                                  if (imageLink.isEmpty) {
                                    //return Center(child: CircularProgressIndicator());
                                    return Center(
                                      child: InkWell(
                                        onTap: (){
                                          pickUploadCartGrisePic(userController);
                                        },

                                        child: Container(

                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.3), shape: BoxShape.circle,
                                            border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.all(25),
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 2, color: Colors.white),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(Icons.camera_alt, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Container(
                                          child: CustomImage(
                                            image: imageLink,
                                            height: 150,
                                            width: 150,
                                            fit: BoxFit.cover,
                                            placeholder: '',
                                          )
                                      ),
                                    );
                                  }
                                }
                            ),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                          !userController.isLoading ? CustomButton(
                            onPressed: () {
                              validation(userController);
                              Get.offNamed(RouteHelper.getAccountPage());
                            },
                            margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            buttonText: 'Send',
                          ) : Center(child: CircularProgressIndicator()),

                        ]),
                  ),
                ),
              ),
            ],
          ) : Center(child: CircularProgressIndicator()) : GoToSignInPage();
        }),
      ),
    );
  }
}