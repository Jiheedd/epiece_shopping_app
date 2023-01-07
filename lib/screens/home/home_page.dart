import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:epiece_shopping_app/base/BNBCustomPainter.dart';
import 'package:epiece_shopping_app/components/colors.dart';
import 'package:epiece_shopping_app/screens/account/account_page.dart';
import 'package:epiece_shopping_app/screens/cart/cart_history.dart';
import 'package:epiece_shopping_app/screens/cart/cart_page.dart';
import 'package:epiece_shopping_app/screens/home/home_page_body.dart';
import 'package:epiece_shopping_app/screens/order/order_screen.dart';
import 'package:epiece_shopping_app/uitls/app_constants_2.dart';
import 'package:epiece_shopping_app/uitls/app_dimensions.dart';
import 'package:epiece_shopping_app/uitls/coustom_bottom_nav_bar.dart';
import 'package:epiece_shopping_app/uitls/enums.dart';
import 'package:epiece_shopping_app/uitls/size_config.dart';

import '../../routes/route_helper.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex=0;
  IconData icon = Icons.shopping_cart;
  List pages=[
    HomePageBody(),
    OrderScreen(),
    CartHistory(),
    AccountPage(),
    CartPage(pageId:1 ,page:"home"),
  ];

  void onTap(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xFFf9f9fa),
        body:pages[_selectedIndex],
        //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home, onTap: onTap(_selectedIndex),)
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //Navigator.pushNamed(context, RouteHelper.cartPage);
            //Get.toNamed(RouteHelper.getCartPage(1, "home"));
            //Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage(pageId:1 ,page:"home")));
            if (_selectedIndex == 0 || _selectedIndex == 1 || _selectedIndex == 2 || _selectedIndex == 3) {
              onTap(4);
              icon = Icons.home;
            } else if (_selectedIndex == 4) {
              onTap(0);
              icon = Icons.shopping_cart;
            }


          },
          backgroundColor: kPrimaryColor,
          child: Icon(icon),
          elevation: 9,
        ) ,
        bottomNavigationBar: Stack(
          //overflow: Overflow.visible,
          children: [
            CustomPaint(
              size: Size(Dimensions.screenSizeWidth, getProportionateScreenHeight(160)),
              painter: BNBCustomPainter(),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.025),
                    child: IconButton(icon: Icon(Icons.home, color: AppColors.buttonBackgroundColor, size: getProportionateScreenWidth(30),), onPressed: () {onTap(0);icon = Icons.shopping_cart;},),
                  ),
                  IconButton(icon: Icon(Icons.map, color: AppColors.buttonBackgroundColor, size: getProportionateScreenWidth(30),), onPressed: () {
                    onTap(1);
                    icon = Icons.shopping_cart;
                    },),
                  //IconButton(icon: Icon(Icons.home, color: Theme.of(context).accentColor,), onPressed: () {},),
                  SizedBox(width: 50,),
                  IconButton(icon: Icon(Icons.archive, color: AppColors.buttonBackgroundColor, size: getProportionateScreenWidth(30),), onPressed: () {onTap(2);icon = Icons.shopping_cart;},),
                  Padding(
                    padding: EdgeInsets.only(right: SizeConfig.screenWidth * 0.025),
                    child: IconButton(icon: Icon(Icons.person, color: AppColors.buttonBackgroundColor, size: getProportionateScreenWidth(30),), onPressed: () {onTap(3);icon = Icons.shopping_cart;},),
                  ),
                ],
              ),
            ),

          ],
        ),

      );

  }
}
