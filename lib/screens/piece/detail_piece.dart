
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epiece_shopping_app/components/colors.dart';
import 'package:epiece_shopping_app/components/expanded_widget.dart';
import 'package:epiece_shopping_app/controllers/cart_controller.dart';
import 'package:epiece_shopping_app/controllers/product_controller.dart';
import 'package:epiece_shopping_app/routes/route_helper.dart';
import 'package:epiece_shopping_app/uitls/app_constants.dart';
import 'package:epiece_shopping_app/uitls/app_dimensions.dart';
import 'package:epiece_shopping_app/widgets/big_text.dart';
import 'package:epiece_shopping_app/widgets/icon_text_widget.dart';
import 'package:epiece_shopping_app/widgets/text_widget.dart';
import 'package:get/get.dart';

import '../../uitls/trimWord.dart';


class DetailPiece extends StatelessWidget {
  int pageId;
  String page;
  DetailPiece({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(Get.find<CartController>().getCartsData());
    //we are getting a model here
    print("hi Jihed......... " +pageId.toString());
    var productItem = Get.find<ProductController>().popularProductList[pageId];
    Get.find<ProductController>().initData(productItem, pageId, Get.find<CartController>()
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: Dimensions.sliverHeight,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(productItem.img),
                    )
                ),
              )),
          Positioned(
              top: 50,
              left: 20,
              right: 20,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 6),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white70,
                    ),
                    child: GestureDetector(
                      onTap: (){
                        // Get.toNamed(RouteHelper.getInitialRoute());
                        Get.back();
                        //  Get.offNamed(RouteHelper.getInitialRoute());
                      },
                      child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color: AppColors.mainColor,
                          )),
                    ),
                  ),
                ],
              )),

          Positioned(
              left: 0,
              right: 0,
              top: Dimensions.sliverHeight-30,
              // bottom: 0,
              child: Container(
                height: 500,
                //width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 20, right: 20, top:20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.padding20),
                        topLeft: Radius.circular(Dimensions.padding20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                        size: Dimensions.font26,
                        text: productItem.title,
                        color: Colors.black87),
                    SizedBox(
                      height: Dimensions.padding10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                              productItem.stars??1,
                                  (index) => Icon(Icons.star,
                                  color: AppColors.mainColor, size: 15)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextWidget(text: productItem.stars.toString(), color: Colors.orangeAccent,size: 15,),
                        const SizedBox(
                          width: 10,
                        ),

                        Expanded(
                          child: Text(
                            productItem.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: const TextStyle(
                              color:Color(0xFFccc7c5),
                              fontSize:12,
                              //height: height
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.padding20,
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            IconAndTextWidget(
                              text: " ",
                              color: AppColors.textColor,
                              icon: Icons.location_on,
                              iconColor: AppColors.mainColor,
                            ),
                            Expanded(
                              child: Text(
                                productItem.location.toString().trim(),
                                //textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                  color:AppColors.textColor,
                                  fontSize:15,
                                  //height: height
                                ),
                              ),
                            ),

                            SizedBox(
                              width: Dimensions.padding20,
                            ),

                            IconAndTextWidget(
                              text: " ",
                              color: AppColors.textColor,
                              icon: Icons.phone,
                              iconColor: AppColors.iconColor2,
                            ),
                            Text(
                              trimFirstWord(productItem.price.toString(), '.'),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                color:AppColors.textColor,
                                fontSize:15,
                                //height: height
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.padding20,
                    ),
                    BigText(
                        size: 22,
                        text: "Introduce",
                        color: AppColors.titleColor),
                    SizedBox(
                      height: Dimensions.padding20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: DescriptionTextWidget(text:productItem.description),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),

      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            left: Dimensions.detailPieceImgPad,
            right: Dimensions.detailPieceImgPad),
        height: Dimensions.buttonButtonCon,
        padding:
        EdgeInsets.only(top: Dimensions.padding30,
            bottom: Dimensions.padding30, left: 20, right: 20),
        child: Row(
          children: [
            Container(
              child: BigText(
                size: 20,
                text: "Page Facebook",
                color: Colors.white,
              ),
              padding:  EdgeInsets.all(Dimensions.padding20),
              decoration: BoxDecoration(
                  color: AppColors.BlueFacebook,
                  borderRadius: BorderRadius.circular(Dimensions.padding20),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 5),
                        blurRadius: 10,
                        //spreadRadius: 3,
                        color: AppColors.signColor)
                  ]),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: (){
                Get.find<ProductController>().addItem(productItem);

              },
              child: Container(
                child: BigText(
                  size: 20,
                  text: "Appeler",
                  color: Colors.white,
                ),
                padding:  EdgeInsets.all(Dimensions.padding20),
                decoration: BoxDecoration(
                    color: AppColors.greenSuccess,
                    borderRadius: BorderRadius.circular(Dimensions.padding20),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 5),
                          blurRadius: 10,
                          //spreadRadius: 3,
                          color: AppColors.mainColor.withOpacity(0.3))
                    ]),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.padding40),
              topRight: Radius.circular(Dimensions.padding40),
            )),
      ),
    );
    // );
  }
}
