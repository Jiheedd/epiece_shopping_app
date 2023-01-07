import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:epiece_shopping_app/base/custom_loader.dart';
import 'package:epiece_shopping_app/base/custom_snackbar.dart';
import 'package:epiece_shopping_app/base/no_data_found.dart';
import 'package:epiece_shopping_app/components/colors.dart';
import 'package:epiece_shopping_app/controllers/auth_controller.dart';
import 'package:epiece_shopping_app/controllers/cart_controller.dart';
import 'package:epiece_shopping_app/controllers/location_controller.dart';
import 'package:epiece_shopping_app/controllers/popular_product.dart';
import 'package:epiece_shopping_app/controllers/product_controller.dart';
import 'package:epiece_shopping_app/controllers/user_controller.dart';
import 'package:epiece_shopping_app/data/repos/order_controller.dart';
import 'package:epiece_shopping_app/models/cart_item.dart';
import 'package:epiece_shopping_app/models/place_order.dart';
import 'package:epiece_shopping_app/routes/route_helper.dart';
import 'package:epiece_shopping_app/screens/home/home_page.dart';
import 'package:epiece_shopping_app/uitls/app_constants.dart';
import 'package:epiece_shopping_app/uitls/app_constants_2.dart';
import 'package:epiece_shopping_app/uitls/app_dimensions.dart';
import 'package:epiece_shopping_app/uitls/size_config.dart';
import 'package:epiece_shopping_app/widgets/big_text.dart';
import 'package:epiece_shopping_app/widgets/text_widget.dart';

import 'custom_cart_bar.dart';

class CartPage extends StatelessWidget {
  final int? pageId;
  String? page;
   CartPage({Key? key, this.pageId, this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
  //  var location = Get.find<LocationController>().getUserAddress();

    return Scaffold(
    backgroundColor: Colors.white,
    appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomCartBar(pageId: pageId!, page: page!),
      ),
      body:Stack(
        children: [
          GetBuilder<CartController>(builder: (_){
            return  Get.find<CartController>().getCarts.length>0?Positioned(
                top: 20,
                left: 0,
                right: 0,
                //with bottom property 0, we can make it scrollable
                bottom: 0,
                child: Container(
                  color: Colors.white,
                  // height: 600,
                  //width: 300,
                  child:  GetBuilder<CartController>(builder: (cartController){
                    // print("here from cart "+cartController.getCarts[1].quantity.toString());
                    List<CartItem> _cartList = Get.find<CartController>().getCarts;
                    return  MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_, index){
                            return Container(
                              color: Colors.grey.shade50,
                              width: double.maxFinite,
                              height: getProportionateScreenHeight(200),
                              margin:  EdgeInsets.all(Dimensions.padding10),
                              child: _cartList[index].quantity>0?
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //this setting should come at the end to make sense. this is important for the cart + - button
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        var getPageIndex=Get.find<ProductController>().popularProductList.indexOf(_cartList[index].product);

                                        // page = "recommended";
                                        if(getPageIndex<0){
                                          getPageIndex=Get.find<PopularProduct>().popularProductList.indexOf(_cartList[index].product);
                                          // page="popular";
                                        }
                                        if(getPageIndex<0){
                                          showCustomSnackBar("Product review is not available from cart history", isError: false,title: "Order more");

                                        }else{
                                          if(page=="recommended"){
                                            Get.toNamed(RouteHelper.getRecommendedPieceRoute(getPageIndex, page!));
                                          }else if(page=="popular"){
                                            Get.toNamed(RouteHelper.getPopularPieceRoute(getPageIndex, page!, RouteHelper.cartPage));
                                          }else if(page=='cart-history'){
                                            showCustomSnackBar("Product review is not available from cart history", isError: false,title: "Order more");
                                          }else{
                                            Get.toNamed(RouteHelper.getInitialRoute());
                                          }
                                        }
                                      },
                                      child: Center(
                                        child: Container(
                                          width: 85,
                                          height: 85,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      _cartList[index].img
                                                  )
                                              ),
                                              borderRadius: BorderRadius.circular(Dimensions.padding20),
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.padding10,),
                                    Expanded(
                                      child: Container(
                                        //since column needs height, without this container height this column would take min
                                        //size. Previously this column inside the Row, it didn't know the height. Now because of
                                        //container height, column would occupy the maximun height
                                        height: 100,
                                        //width:260,
                                        child: Column(
                                          //mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          //spacebetween pushes to the end of the upper boundary
                                          //spaceAround has the middle upper boundary
                                          //spaceEvenly has the lowest upper boundary
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(

                                              cartController.getCarts[index].title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(

                                                color:Colors.black54,
                                                fontSize:getProportionateScreenWidth(15),
                                                fontWeight: FontWeight.w600,

                                              ),
                                            ),
                                            /* BigText(text: cartController.getCarts[index].title,
                                                    color: AppColors.titleColor),*/

                                            TextWidget(text:cartController.getCarts[index].product.sub_title.toString(), color:AppColors.textColor,),
                                            Row(
                                              children: [
                                                BigText(text: " د ", color: AppColors.mainColor),
                                                BigText(text: cartController.getCarts[index].price.toString(), color: AppColors.mainColor, size: 16,),
                                                SizedBox(width: Dimensions.padding10,),
                                                Expanded(child: Container()),
                                                Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: Container(
                                                    padding:  EdgeInsets.all(Dimensions.padding5),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: (){

                                                            var quantity = -1;
                                                            Get.find<CartController>().addItem(_cartList[index].product, quantity);

                                                          },
                                                          child: Icon(Icons.remove, color: AppColors.signColor),
                                                        ),
                                                        SizedBox(width: Dimensions.padding5),
                                                        GetBuilder<ProductController>(builder: (_){
                                                          return BigText(text: _cartList[index].quantity.toString(), color: AppColors.mainBlackColor, size: 16,);
                                                        },),
                                                        SizedBox(width: Dimensions.padding5),
                                                        GestureDetector(
                                                          onTap: (){
                                                            var quantity = 1;
                                                            Get.find<CartController>().addItem(_cartList[index].product, quantity);

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
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                              )
                                  :Container(),
                            );
                          }),
                    );
                  }),
                )):NoDataScreen(text: "Your cart is empty!");
          })
        ],

      ),

      bottomNavigationBar: Stack(
        children: [
          GetBuilder<OrderController>(builder: (orderController){
            return !orderController.isLoading? Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(
                  left: Dimensions.detailPieceImgPad,
                  right: Dimensions.detailPieceImgPad),
              height: Dimensions.buttonButtonCon,
              padding:
              EdgeInsets.only(top: Dimensions.padding20, bottom: Dimensions.padding30, left: 10, right: 10),
              child: GetBuilder<CartController>(builder: (_){
                return Get.find<CartController>().getCarts.length>0?Row(
                  children: [
                    Container(
                      padding:  EdgeInsets.all(Dimensions.padding20),
                      child: Row(
                        children: [
                          SizedBox(width: Dimensions.padding10),
                          GetBuilder<CartController>(builder: (_){
                            return BigText(text: "\$ "+ Get.find<CartController>().totalAmount.toString(), color: Colors.green);
                          },),
                          SizedBox(width: Dimensions.padding10),
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

                    GestureDetector(
                        onTap: (){
                          if(!Get.find<AuthController>().isLoggedIn()){
                            Get.toNamed(RouteHelper.getSignInRoute());
                          }else{
                            if(Get.find<LocationController>().addressList.isEmpty){
                              Get.toNamed(RouteHelper.getAddAddressRoute());
                            }else{
                              var location = Get.find<LocationController>().getUserAddress();
                              orderController.placeOrder(PlaceOrderBody(
                                cart: Get.find<CartController>().getCarts,
                                /*
                            next line 100 is a fake data
                             */
                                orderAmount: 100.0,
                                orderNote: "Note about piece",
                                address: location.address,
                                latitude: location.latitude,
                                longitude: location.longitude,
                                contactPersonName: location.contactPersonName ?? Get.find<UserController>().userInfoModel!.fName,
                                contactPersonNumber: location.contactPersonNumber ?? Get.find<UserController>().userInfoModel!.phone,
                                scheduleAt: '', distance: 10,
                              ), _callback);

                              Get.find<CartController>().clear();
                              Get.find<CartController>().removeCartSharedPreference();
                              Get.find<CartController>().addToHistory();
                            }
                          }
                        },
                        child: Container(
                          child: BigText(
                            size: 20,
                            text: "Check out",
                            color: Colors.white,
                          ),
                          padding:  EdgeInsets.all(Dimensions.padding20),
                          decoration: BoxDecoration(
                              color: AppColors.greenSuccess,
                              borderRadius: BorderRadius.circular(Dimensions.padding20),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 5),
                                    blurRadius: 10,
                                    //spreadRadius: 3,
                                    color: AppColors.mainColor.withOpacity(0.3))
                              ]),
                        )
                    )

                  ],
                ):Container();
              }),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.padding20),
                    topRight: Radius.circular(Dimensions.padding20),
                  )),
            ):CustomLoader();
        }),
          /*
          GestureDetector(
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
              Get.toNamed(RouteHelper.getInitialRoute());
            },
            child: Center(
              heightFactor: 0.01,
              child: FloatingActionButton(
                  backgroundColor: kPrimaryColor,
                  child: Icon(Icons.home, size: getProportionateScreenWidth(35),),
                  elevation: 9,
                  onPressed: () {
                    Get.offNamed(RouteHelper.getInitialRoute());
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                  }),
            ),
          ),
           */
        ]
      )
    );
  }
  void _callback(bool isSuccess, String message, String orderID) async {
    if(isSuccess) {

      Get.find<CartController>().clearCartList();

      Get.find<OrderController>().stopLoader();
      if( isSuccess == true) {
        //Get.offNamed(RouteHelper.getOrderSuccessRoute(orderID, 'success'));
        //Get.offNamed(RouteHelper.getInitialRoute());
        showCustomSnackBar(message, isError: false, title: "Order passed successfully");

        Get.offNamed(RouteHelper.getOrderSuccessRoute(orderID, 'success'));

      }else {
        if(GetPlatform.isWeb) {
          Get.back();
         // String hostname = html.window.location.hostname;
         // String protocol = html.window.location.protocol;
         // String selectedUrl = '${AppConstants.BASE_URL}/payment-mobile?order_id=$orderID&&customer_id=${Get.find<UserController>()
           //   .userInfoModel.id}&&callback=$protocol//$hostname${RouteHelper.orderSuccess}?id=$orderID&status=';
          //html.window.open(selectedUrl,"_self");
        } else{
          print("working fine");
          Get.offNamed(RouteHelper.getInitialRoute());
        }
      }
    }else {
      print(message);
      showCustomSnackBar("You can follow the order from the orders section", isError: false, title: "Order passed successfully");
      Get.offNamed(RouteHelper.getOrderSuccessRoute(orderID, 'success'));
    }
  }
}
