import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:epiece_shopping_app/base/custom_snackbar.dart';
import 'package:epiece_shopping_app/components/colors.dart';
import 'package:epiece_shopping_app/controllers/cart_controller.dart';
import 'package:epiece_shopping_app/routes/route_helper.dart';
import 'package:epiece_shopping_app/uitls/app_constants_2.dart';
import 'package:epiece_shopping_app/uitls/size_config.dart';


class CustomCartBar extends StatelessWidget {
  int pageId;
  String page;

  CustomCartBar({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20), vertical: 10),
        child: Row(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  primary: kPrimaryColor,
                  backgroundColor: Colors.black12.withOpacity(0.05),
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  //Get.offNamed(RouteHelper.getInitialRoute());
                  /*if(page=="recommended"){
                    Get.toNamed(RouteHelper.getRecommendedPieceRoute(pageId, page));
                  }else if(page=='popular'){
                    Get.toNamed(RouteHelper.getPopularPieceRoute(pageId, page, RouteHelper.cartPage));
                  }else{*/
                    Get.offNamed(RouteHelper.getInitialRoute());
                  //}
                },
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 15,
                ),
              ),
            ),
            Spacer(),

          ],
        ),
      ),
    );
  }
}
