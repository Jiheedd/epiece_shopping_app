import 'package:flutter/material.dart';
import 'package:epiece_shopping_app/uitls/size_config.dart';

import 'UserIcon.dart';

class Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 10),
      margin:  EdgeInsets.only(top:getProportionateScreenHeight(25)),
      height: SizeConfig.screenHeight*0.8,
      width: SizeConfig.screenWidth ,
      child: Center(
          child: UserIcon()
      ),
    );
  }
}
