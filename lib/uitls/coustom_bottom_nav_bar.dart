import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:epiece_shopping_app/base/BNBCustomPainter.dart';
import 'package:epiece_shopping_app/uitls/app_dimensions.dart';
import 'package:epiece_shopping_app/uitls/size_config.dart';

import 'app_constants_2.dart';
import 'enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);


  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFF8EA04);
    // final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Stack(
      //overflow: Overflow.visible,
      children: [
        CustomPaint(
          size: Size(Dimensions.screenSizeWidth, 80),
          painter: BNBCustomPainter(),
        ),
        Center(
          heightFactor: 0.3,
          child: FloatingActionButton(
              backgroundColor: kPrimaryColor,
              child: Icon(Icons.shopping_cart),
              elevation: 0.8,
              onPressed: () {}),
        ),
        Container(
          width: Dimensions.screenSizeWidth,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: Dimensions.screenSizeWidth * 0.08,
                  //color: currentIndex == 0 ? Colors.orange : Colors.grey.shade400,
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, HomeScreen.routeName);
                },
                splashColor: Colors.white,
              ),
              IconButton(
                  icon: Icon(
                    Icons.map,
                    color: Colors.white,
                    size: Dimensions.screenSizeWidth * 0.08,
                    //color: currentIndex == 1 ? Colors.orange : Colors.grey.shade400,
                  ),
                  onPressed: () {

                  }),
              Container(
                width: Dimensions.screenSizeWidth * 0.20,
              ),
              IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: Dimensions.screenSizeWidth * 0.08,
                    //color: currentIndex == 2 ? Colors.orange : Colors.grey.shade400,
                  ),
                  onPressed: () {

                  }),
              IconButton(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: Dimensions.screenSizeWidth * 0.08,
                    //color: currentIndex == 3 ? Colors.orange : Colors.grey.shade400,
                  ),
                  onPressed: () {
                    //Navigator.pushNamed(context, ProfileScreen.routeName);
                  }),
            ],
          ),
        )
      ],
    );
  }
}



/*
import 'package:epiece/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:epiece/screens/home/home_screen.dart';
import 'package:epiece/screens/profile/profile_screen.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(14)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.45),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),

      ),

      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset("assets/icons/Heart Icon.svg"),
                onPressed: () {},
              ),
              FloatingActionButton(
                child: Icon(
                    Icons.shopping_cart
                ),
                onPressed: () => Navigator.pushNamed(context, ProfileScreen.routeName),
                elevation: 6.0,
                isExtended: true,

              ),
              IconButton(
                icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, ProfileScreen.routeName),
              ),
            ],
          )
      ),

    );
  }
}

 */
