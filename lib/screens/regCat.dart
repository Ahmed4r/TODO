import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/appcolor.dart';
import 'package:todolist/providers/app_config_provider.dart';

typedef MyValidator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  String label;
  MyValidator validator;
  bool securedText;
  TextEditingController controller;
  TextInputType keyboardType;
  CustomTextFormField(
      {this.securedText = false,
      this.keyboardType = TextInputType.text,
      required this.label,
      required this.controller,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        style: TextStyle(
            color: provider.isdarkmode() ? Colors.white : Colors.black),
        validator: validator,
        obscureText: securedText,
        controller: controller,
        decoration: InputDecoration(
            errorMaxLines: 2,
            labelText: label,
            labelStyle: TextStyle(
                color: provider.isdarkmode()
                    ? Appcolors.whiteColor
                    : Appcolors.blackColorCategory),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Appcolors.redColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Appcolors.redColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Appcolors.blueColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Appcolors.blueColor))),
      ),
    );
  }
}
