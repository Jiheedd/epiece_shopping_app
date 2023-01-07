import 'package:flutter/material.dart';
import 'package:epiece_shopping_app/screens/auth/sign_up_page.dart';
import 'package:epiece_shopping_app/uitls/app_constants_2.dart';
import 'package:epiece_shopping_app/uitls/size_config.dart';



class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () =>
          //Navigator.pushNamed(context, SignUpScreen.routeName),
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage())),

          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
