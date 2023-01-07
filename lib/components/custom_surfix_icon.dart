import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:epiece_shopping_app/components/colors.dart';
import 'package:epiece_shopping_app/uitls/size_config.dart';



class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(0),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(0),
      ),
      child: Icon(
          icon,
          color: AppColors.mainColor
      ),
      /*
      SvgPicture.asset(
        svgIcon,
        height: getProportionateScreenWidth(18),
      ),*/
    );
  }
}
