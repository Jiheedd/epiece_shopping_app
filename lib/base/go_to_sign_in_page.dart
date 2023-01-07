import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epiece_shopping_app/components/colors.dart';
import 'package:epiece_shopping_app/routes/route_helper.dart';
import 'package:epiece_shopping_app/uitls/app_dimensions.dart';
import 'package:epiece_shopping_app/uitls/size_config.dart';
import 'package:epiece_shopping_app/widgets/big_text.dart';
import 'package:get/get.dart';
class GoToSignInPage extends StatelessWidget {
  const GoToSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: Dimensions.screenSizeWidth,
      height: Dimensions.screenSizeHeight*0.8995,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/image/forget_password.png"),
          SizedBox(height: getProportionateScreenHeight(20),),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getSignInRoute());
            },
            child: Container(
              height: getProportionateScreenHeight(120),
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(
                      text: "Sign in here! ",
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.login,
                      color: Colors.white,
                      size: getProportionateScreenWidth(30),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
