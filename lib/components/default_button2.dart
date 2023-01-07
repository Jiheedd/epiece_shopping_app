import 'package:flutter/material.dart';
import 'package:epiece_shopping_app/uitls/app_constants_2.dart';
import 'package:epiece_shopping_app/uitls/size_config.dart';


class DefaultButton2 extends StatelessWidget {
  const DefaultButton2({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth*0.8,
      height: SizeConfig.screenHeight*0.15,
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          primary: Colors.white,
          backgroundColor: kPrimaryColor,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
