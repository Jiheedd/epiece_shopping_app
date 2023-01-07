import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epiece_shopping_app/components/colors.dart';
import 'package:epiece_shopping_app/components/custom_surfix_icon.dart';
import 'package:epiece_shopping_app/uitls/size_config.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final IconData icon;
  final TextInputType textInputType;
  final TextEditingController textController;
  final bool readOnly;
  const AppTextField({Key? key,
  required this.hintText,required this.textController, required this.icon, this.readOnly=false, this.labelText, required this.textInputType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 7,
                offset: Offset(1, 1),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextFormField(
        readOnly: readOnly,
        controller: textController,
        textInputAction: TextInputAction.next,
        keyboardType: textInputType,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.signColor,
              fontSize: getProportionateScreenWidth(13),
            ),
            labelText: labelText,
            labelStyle: TextStyle(
              color: AppColors.paraColor,
              fontSize: getProportionateScreenWidth(15),
            ),
            //prefixIcon: Icon(icon, color: Colors.grey),
            //floatingLabelBehavior: FloatingLabelBehavior.always,

            suffixIcon: CustomSurffixIcon(icon: icon),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: AppColors.mainColor,
                    width: 1.0
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0
                )
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
            )
        ),
      ),
    );
  }
}