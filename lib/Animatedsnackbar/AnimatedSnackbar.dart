
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
void showSnackBar(BuildContext context, String title, String text) {
  AnimatedSnackBar.rectangle(
    title,
    text,
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    duration: const Duration(seconds: 2),
    type: AnimatedSnackBarType.success,
    brightness:Brightness.dark,
  ).show(context);
}
