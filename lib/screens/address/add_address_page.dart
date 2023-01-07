import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:epiece_shopping_app/base/custom_image.dart';
import 'package:epiece_shopping_app/base/go_to_sign_in_page.dart';
import 'package:epiece_shopping_app/components/colors.dart';
import 'package:epiece_shopping_app/components/custom_surfix_icon.dart';
import 'package:epiece_shopping_app/controllers/auth_controller.dart';
import 'package:epiece_shopping_app/controllers/location_controller.dart';
import 'package:epiece_shopping_app/controllers/user_controller.dart';
import 'package:epiece_shopping_app/models/address_model.dart';
import 'package:epiece_shopping_app/routes/route_helper.dart';
import 'package:epiece_shopping_app/screens/address/pick_map_screen.dart';
import 'package:epiece_shopping_app/uitls/app_dimensions.dart';
import 'package:epiece_shopping_app/uitls/size_config.dart';
import 'package:epiece_shopping_app/widgets/app_text_field.dart';
import 'package:epiece_shopping_app/widgets/big_text.dart';

import '../../base/custom_snackbar.dart';
import '../location/permission_dialogue.dart';

class AddAddressScreen extends StatefulWidget {

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
   TextEditingController _addressController = TextEditingController();
   TextEditingController _contactPersonNameController = TextEditingController();
   TextEditingController _contactPersonNumberController = TextEditingController();

   String carteGriseLink = "";
   late bool _isCartChanged;

  late bool _isLoggedIn;
    CameraPosition _cameraPosition=CameraPosition(target:
    LatLng(45.521563, -122.677433),zoom: 17);
   late LatLng _initialPosition;

  @override
  void initState() {
    super.initState();

    _isCartChanged = false;
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
   if(Get.find<LocationController>().addressList.isEmpty){
     _initialPosition =  LatLng(36.806389, 10.181667);
   }else{
     if(Get.find<LocationController>().getUserAddress().address.isNotEmpty){
       print("My address is "+Get.find<LocationController>().getUserAddress().address);
       print("Lat is "+Get.find<LocationController>().getAddress["latitude"].toString());

       _cameraPosition=
           CameraPosition(target:
           LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]),
           double.parse(Get.find<LocationController>().getAddress["longitude"])),zoom: 17);
       _initialPosition =
           LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]),
           double.parse(Get.find<LocationController>().getAddress["longitude"]));
     }/*else{
       print("Are we here");
       _initialPosition =  LatLng(45.521563, -122.677433);
     }*/
   }
  }

   void pickUploadCartGrisePic(UserController userController) async {
     final image = await ImagePicker().pickImage(
       source: ImageSource.camera,
       maxHeight: 512,
       maxWidth: 512,
       imageQuality: 90,
     );
     Reference ref = FirebaseStorage.instance
         .ref("CarteGrise/").child(userController.userInfoModel!.id.toString()+".jpg");
     //    .ref("UserImage/");

     await ref.putFile(File(image!.path));

     print (image);
     ref.getDownloadURL().then((value) async {
       setState(() {
         carteGriseLink = value;
         print(value);
         _isCartChanged = true;
       });
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("Add Address"),
      ),
      body: _isLoggedIn ? GetBuilder<UserController>(builder: (userController) {

          _contactPersonNameController.text = '${userController.userInfoModel?.fName}';
          _contactPersonNumberController.text = '${userController.userInfoModel?.phone}';
          _addressController.text=Get.find<LocationController>().getUserAddress().address;

          /*if(Get.find<LocationController>().addressList.isNotEmpty){
            _addressController.text=Get.find<LocationController>().getUserAddress().address;
            print("address from database" + _addressController.text);
          }*/


        return GetBuilder<LocationController>(builder: (locationController) {
          //comes at the end of this tutorial page.
          /*_addressController.text = '${locationController.placeMark.name ?? ''} '
              '${locationController.placeMark.locality ?? Get.find<LocationController>().getUserAddress().address} '
              '${locationController.placeMark.postalCode ?? ''} '
              '${locationController.placeMark.country ?? ''}';*/
          print("I am getting from placemark "+_addressController.text);
          return Column(children: [
            Expanded(child: Scrollbar(child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Center(
                  child: SizedBox(
                  width: Dimensions.WEB_MAX_WIDTH,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                          Container(
                            height: getProportionateScreenHeight(280),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                              border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                              child: Stack(clipBehavior: Clip.none, children: [
                                GoogleMap(
                                  initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 17),
                                  onTap: (latLng) {

                                    Get.toNamed(RouteHelper.getPickMapRoute('add-address', false),
                                        arguments: PickMapScreen(
                                          fromAddAddress: true,
                                          fromSignUp: false,
                                          googleMapController: locationController.mapController,
                                          route: "",
                                          canRoute: false,
                                    ));
                                  },
                                  zoomControlsEnabled: false,
                                  compassEnabled: false,
                                  indoorViewEnabled: true,
                                  mapToolbarEnabled: false,
                                  myLocationEnabled: true,
                                  onCameraIdle: () {
                                    print("tapping for udpate");
                                    locationController.updatePosition(_cameraPosition, true);
                                  },
                                  onCameraMove: ((position) => _cameraPosition = position),
                                  onMapCreated: (GoogleMapController controller) {
                                    print("I am from address page");
                                    locationController.setMapController(controller);
                                    //locationController.getCurrentLocation(true, mapController: controller);
                                  },
                                ),
                                locationController.loading ? Center(child: CircularProgressIndicator()) : SizedBox(),
                                Center(child: !locationController.loading ? Icon(Icons.web)
                                    : CircularProgressIndicator()),
                                Positioned(
                                  top: 10, right: 0,
                                  child: InkWell(
                                    onTap: () => _checkPermission(() {
                                      locationController.getCurrentLocation(true, mapController: locationController.mapController);
                                    }),
                                    child: Container(
                                      width: 30, height: 30,
                                      margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), color: Colors.white),
                                      child: Icon(Icons.fullscreen, color: Theme.of(context).primaryColor, size: 20),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          SizedBox(height: 50, child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: locationController.addressTypeList.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                locationController.setAddressTypeIndex(index);
                                if(index==2)
                                  _addressController.text = "Tunis";
                                print("Aaaaahyyyy ray l adress "+_addressController.text);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,
                                    vertical: Dimensions.PADDING_SIZE_SMALL),
                                margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                  color: Theme.of(context).cardColor,
                                  boxShadow: [BoxShadow(color: Colors.grey[200]!,
                                      spreadRadius: 1, blurRadius: 5)],
                                ),
                                child: Row(children: [
                                  Icon(
                                    index == 0 ? Icons.home_filled : index == 1 ? Icons.work : Icons.location_on,
                                    color: locationController.addressTypeIndex == index
                                        ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                                  ),
                                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                ]),
                              ),
                            ),
                          )),
                                SizedBox(height: 20),
                                BigText(text:"Delivery Adddress", color:AppColors.mainBlackColor),

                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                  AppTextField(hintText: "Adress location", textController: _addressController, icon: Icons.location_on_outlined, textInputType: TextInputType.name),

                                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                                BigText(text:"Contact person name", color:AppColors.mainBlackColor),

                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                                AppTextField(hintText: "contact person name", textController: _contactPersonNameController, icon: Icons.drive_file_rename_outline, textInputType: TextInputType.name),

                                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                                BigText(text:"Contact person number",color:AppColors.mainBlackColor),
                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                  AppTextField(hintText: "contact person number", textController: _contactPersonNumberController, icon: Icons.phone_callback, textInputType: TextInputType.phone),

                                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                                BigText(text:"Carte grise", color:AppColors.mainBlackColor),

                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                            Center(
                              child: Builder(
                                  builder: (context) {
                                    if (carteGriseLink.isEmpty) {
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
                                              image: carteGriseLink,
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




                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                Container(
                                  height: Dimensions.height20*8,
                                  padding: EdgeInsets.only(top:Dimensions.height30, bottom: Dimensions.height30,
                                      left: Dimensions.width20, right: Dimensions.width20),
                                  decoration: BoxDecoration(
                                      color: AppColors.buttonBackgroundColor,
                                      borderRadius: BorderRadius.only(

                                          topLeft: Radius.circular(Dimensions.radius20*2),
                                          topRight: Radius.circular(Dimensions.radius20*2)
                                      )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      GestureDetector(
                                          onTap: (){
                                            print("here is "+_addressController.text);
                                            AddressModel _addressModel = AddressModel(
                                              addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                                              contactPersonName: _contactPersonNameController.text,
                                              contactPersonNumber: _contactPersonNumberController.text,
                                              address: _addressController.text,
                                              //latitude: locationController.position.latitude.toString()??36.806389,
                                              latitude: "36.806389",
                                              //longitude: locationController.position.longitude.toString()??10.181667,
                                              longitude: "10.181667",
                                            );
                                            locationController.addAddress(_addressModel).then((response){
                                              if(_isCartChanged == false){
                                                Get.snackbar("Grey Card", "Please add the Grey Card");
                                              }else if (!response.isSuccess){
                                                Get.snackbar("Address", "please fill the fields");
                                              } else {
                                                Get.toNamed(RouteHelper.getInitialRoute());
                                                Get.snackbar("Address", "Added Successfully");
                                              }
                                            });
                                          },
                                          child:Container(
                                            padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20, right: Dimensions.width20),

                                            child: BigText(text: "Save address", color: Colors.white,size:26),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                color: AppColors.mainColor
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                        ]
                      )
                  )
              ),
                ))),

              ]);
            });
          }) : GoToSignInPage(),

    );
  }
   void _checkPermission(Function onTap) async {
     LocationPermission permission = await Geolocator.checkPermission();
     if(permission == LocationPermission.denied) {
       permission = await Geolocator.requestPermission();
     }
     if(permission == LocationPermission.denied) {
       showCustomSnackBar('you_have_to_allow'.tr);
     }else if(permission == LocationPermission.deniedForever) {
       Get.dialog(PermissionDialog());
     }else {
       onTap();
     }
   }
}