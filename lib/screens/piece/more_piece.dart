import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epiece_shopping_app/components/colors.dart';
import 'package:epiece_shopping_app/components/default_button.dart';
import 'package:epiece_shopping_app/components/expanded_widget.dart';
import 'package:epiece_shopping_app/controllers/cart_controller.dart';
import 'package:epiece_shopping_app/controllers/popular_product.dart';
import 'package:epiece_shopping_app/controllers/product_controller.dart';
import 'package:epiece_shopping_app/routes/route_helper.dart';
import 'package:epiece_shopping_app/screens/piece/custom_item_bar.dart';
import 'package:epiece_shopping_app/uitls/app_constants.dart';
import 'package:epiece_shopping_app/uitls/app_dimensions.dart';
import 'package:epiece_shopping_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:epiece_shopping_app/widgets/text_widget.dart';

class MorePiece extends StatelessWidget {
  int pageId;
  String page;
  String route;

  MorePiece({Key? key, required this.pageId, required this.page, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productItem = Get.find<PopularProduct>().popularProductList[pageId];
    Get.find<ProductController>()
        .initData(productItem, pageId, Get.find<CartController>());
    String image = productItem.img;


    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomItemBar(pageId: pageId, page: page,rating: 3),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5, top:10),
                  decoration: const BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )
                  ),
                  width: double.maxFinite,
                  child:Center(
                    child: BigText(
                        text:productItem.title, color:AppColors.mainBlackColor
                    ),
                  ),
                ),
              ),
            //without this we see an arrow
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.yellowColor,
            //without this the top bar is very thin
              //it starts from bottom
            toolbarHeight: 60,
            floating: false,
              //stick top
            pinned: true,
            expandedHeight: 300,

            flexibleSpace: FlexibleSpaceBar(

                background: Image.network(
                  //AppConstants.UPLOADS_URL + productItem.img,
                  image,
                  fit: BoxFit.fill,
                  width: double.maxFinite,
                  height: Dimensions.moreViewCon,
                ),

          )),
          SliverToBoxAdapter(

            child: Column(
              children: [
                //SizedBox(height: 10,),
                Container(

                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child:  DescriptionTextWidget(text: productItem.description)
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(
                left: Dimensions.detailPieceImgPad,
                right: Dimensions.detailPieceImgPad),
            height: Dimensions.buttomButton,
            padding: EdgeInsets.only(
                top: Dimensions.padding20,
                bottom: Dimensions.padding20,
                left: Dimensions.padding20,
                right: Dimensions.padding20),
            child: Row(
              children: [
                Container(
                  padding:  EdgeInsets.all(Dimensions.padding20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.find<ProductController>().setQuantity(false, productItem);
                        },
                        child: Icon(Icons.remove, color: AppColors.signColor),
                      ),
                      SizedBox(width: Dimensions.padding10),
                      GetBuilder<ProductController>(builder: (_){
                        return BigText(text: Get.find<ProductController>().certainItems.toString(), color: AppColors.mainBlackColor);
                      },),
                      SizedBox(width: Dimensions.padding10),
                      GestureDetector(
                        onTap: (){
                          Get.find<ProductController>().setQuantity(true, productItem);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.padding20),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 10,
                            //spreadRadius: 3,
                            color: AppColors.titleColor.withOpacity(0.05))
                      ]),
                ),
                Expanded(child: Container()),
                GetBuilder<ProductController>(builder: (_) {
                  return Container(
                    child: GestureDetector(
                      onTap: () {
                        if (Get.find<ProductController>().certainItems==0)
                          Get.find<ProductController>().setQuantity(true, productItem);
                        Get.find<ProductController>().addItem(productItem);
                      },
                      child: BigText(
                        text: "Add To Cart",
                        color: Colors.white,
                      ),
                    ),
                    padding: EdgeInsets.all(Dimensions.padding20),
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.padding20),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 10,
                              //spreadRadius: 3,
                              color: AppColors.mainColor.withOpacity(0.3))
                        ]),
                  );
                })
              ],
            ),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.padding40),
                  topRight: Radius.circular(Dimensions.padding40),
                )),
          )
        ],
      ),
    );
  }
}
