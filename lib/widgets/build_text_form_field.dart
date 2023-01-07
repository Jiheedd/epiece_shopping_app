import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epiece_shopping_app/components/custom_surfix_icon.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final IconData icon;
  final TextEditingController textController;
  final bool readOnly;
  const AppTextFormField({Key? key,
    required this.hintText,required this.textController, required this.icon, this.readOnly=false, this.labelText}) : super(key: key);

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          controller: textController,
          onSaved: (newValue) => textController.text = newValue!,

          decoration: InputDecoration(
            labelText: "Email",
            hintText: "Enter your email",
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSurffixIcon(icon: icon),
          ),
        ),
      ),
    );
  }
}