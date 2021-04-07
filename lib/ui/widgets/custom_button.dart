import 'package:flutter/material.dart';
import 'package:flutter_catalog/ui/util/app_colors.dart';
import 'package:flutter_catalog/ui/util/ui_helpers.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onTap;

  CustomButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalSpaceBig * 2),
      child: Material(
        borderRadius: BorderRadius.circular(borderRadiusButton),
        color: backgroundColorButton,
        child: Ink(
          height: 30,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(borderRadiusButton),
            child: Center(child: Text(text.toUpperCase())),
          ),
        ),
      ),
    );
  }
}
