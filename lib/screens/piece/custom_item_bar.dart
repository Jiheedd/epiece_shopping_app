import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:epiece_shopping_app/base/custom_snackbar.dart';
import 'package:epiece_shopping_app/components/colors.dart';
import 'package:epiece_shopping_app/controllers/cart_controller.dart';
import 'package:epiece_shopping_app/routes/route_helper.dart';
import 'package:epiece_shopping_app/uitls/app_constants_2.dart';
import 'package:epiece_shopping_app/uitls/size_config.dart';


class CustomItemBar extends StatelessWidget {
  final double rating;
  int pageId;
  String page;

  CustomItemBar({Key? key, required this.pageId, required this.page, required this.rating})
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
                  Navigator.pop(context);

                    //Get.toNamed(RouteHelper.getInitialRoute());

                },
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 15,
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Text(
                    "$rating",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset("assets/icons/Star Icon.svg",width: 14,height: 14,),
                ],
              ),
            ),
            Spacer(),

            GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getCartPage(pageId, page));
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white70,
                ),
                child: GetBuilder<CartController>(builder:(_){
                  return Stack(
                    children: [
                      Positioned(
                        child: Center(
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              size: 25,
                              color: Colors.black54,
                            )),
                      ),
                      Get.find<CartController>().totalItems>=1?Positioned(
                        left: 13,
                        bottom:13,
                        child: Center(
                            child: Icon(
                              Icons.circle,
                              size: 18,
                              color: Colors.red,
                            )),
                      ):Container(),
                      Get.find<CartController>().totalItems>=1?Positioned(
                        right: 4,
                        top:1,
                        child: Center(
                            child:  Text(
                              Get.find<CartController>().totalItems.toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white
                              ),
                            )
                        ),
                      ):Container(),
                      Get.find<CartController>().totalItems>=10?Positioned(
                        left: 12,
                        bottom:12,
                        child: Center(
                            child: Icon(
                              Icons.circle,
                              size: 20,
                              color: Colors.red,
                            )),
                      ):Container(),
                      Get.find<CartController>().totalItems>=10?Positioned(
                        left: 16,
                        bottom:15,
                        child: Center(
                            child:  Text(
                              Get.find<CartController>().totalItems.toString(),
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white
                              ),
                            )
                        ),
                      ):Container(),
                    ],
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
