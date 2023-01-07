import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:epiece_shopping_app/base/custom_loader.dart';
import 'package:epiece_shopping_app/base/custom_snackbar.dart';
import 'package:epiece_shopping_app/components/colors.dart';
import 'package:epiece_shopping_app/components/default_button2.dart';
import 'package:epiece_shopping_app/controllers/auth_controller.dart';
import 'package:epiece_shopping_app/models/signup_body.dart';
import 'package:epiece_shopping_app/routes/route_helper.dart';
import 'package:epiece_shopping_app/uitls/size_config.dart';
import 'package:epiece_shopping_app/widgets/app_text_field.dart';
import 'package:epiece_shopping_app/widgets/big_text.dart';
import 'package:epiece_shopping_app/widgets/build_text_form_field.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    List images =[
      "g.png",
      "f.png"
    ];

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(

      backgroundColor: Colors.white,
      body:GetBuilder<AuthController>(builder: (authController) {
        return
         !authController.isLoading?  SingleChildScrollView(
             physics: BouncingScrollPhysics(),
             child: Column(
                children: [
                  Container(
                    width: w,
                    height: SizeConfig.screenHeight * 0.48,
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: h * 0.13,),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenWidth(50),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    width: w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 20,),
                        AppTextField(hintText:"exemple@exp.com", textController:emailController, icon: Icons.email, labelText: "Enter your email", textInputType: TextInputType.emailAddress,),
                        SizedBox(height: 20,),
                        AppTextField(hintText:"au moins 6 caractères", textController:passwordController, icon:Icons.password_sharp, labelText: "Enter your password",textInputType: TextInputType.visiblePassword),
                        SizedBox(height: 20,),
                        AppTextField(hintText:"numéro de téléphone", textController:phoneController, icon:Icons.phone, labelText: "Enter your phone number",textInputType: TextInputType.phone),
                        SizedBox(height: 20,),
                        AppTextField(hintText:"exp: Khaled", textController:nameController, icon:Icons.person, labelText: "Enter your name",textInputType: TextInputType.name),
                        SizedBox(height: 20,),

                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  DefaultButton2(
                    text: "Sign up",
                    press: () {
                      _register(authController);
                    },
                  ),

                  SizedBox(height: getProportionateScreenWidth(18)),
                  RichText(
                      text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                          text: "Have an account?",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: AppColors.mainBlackColor,
                            decoration: TextDecoration.underline
                          )
                      )
                  ),
                  SizedBox(height: w * 0.08),
                  RichText(text: TextSpan(
                    text: "Sign up using one of the following methods",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16
                    ),

                  )),
                  Wrap(
                    children: List<Widget>.generate(
                        2,
                            (index) {
                          return GestureDetector(
                            onTap: () {

                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                //backgroundColor: AppColors.mainColor,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage(
                                      "img/" + images[index]
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  )
                ],
              ),
           ):CustomLoader();

      }));
    }

  void _register(AuthController authController) async {
    String _firstName = nameController.text.trim();
    String _email = emailController.text.trim();
    String _number = phoneController.text.trim();
    String _password = passwordController.text.trim();


    if (_firstName.isEmpty) {
      showCustomSnackBar("Type in your name", title:"Name");
    }else if (_email.isEmpty) {
      showCustomSnackBar("Type in your Email", title:"Email");
    }else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar("Type in correct Email", title:"Email");
    }else if (_number.isEmpty) {
      showCustomSnackBar("Type in your Phone Number", title:"Phone Number");
    }else if (_number.length != 8) {
      showCustomSnackBar("Phone Number have be 8 numbers", title:"Phone Number");
    }else if (_password.isEmpty) {
      showCustomSnackBar("Type in your Password", title:"Password");
    }else if (_password.length < 6) {
      showCustomSnackBar("Type in equal or more than 6 characters", title:"Password");

    }else {
      SignUpBody signUpBody = SignUpBody(fName: _firstName,
          email: _email,
          phone: _number, password: _password);
      authController.registration(signUpBody).then((status) async {
        if (status.isSuccess) {
            print("success registration");
            Get.offNamed(RouteHelper.getInitialRoute());
        }else {
          Get.snackbar("Wrong", "Something went wrong");

        }
      });
    }
  }
}
